library(brms)
library(bayesplot)
library(tidyverse)
library(glue)
theme_set(theme_classic())

# Model with weakly informative prior
mod1 <- brm(len ~ dose, data = ToothGrowth, 
            prior = prior_string("normal(0, 25)", class = "b", coef = "dose"))

# Model with uniform prior on -1000, 1000
mod2 <- brm(len ~ dose, data = ToothGrowth, 
            prior = prior_string("uniform(-1000, 1000)", class = "b", coef = "dose"))

# Frequentist model
mod3 <- lm(len ~ dose, data = ToothGrowth)

plot_df <- map_df(list(mod1, mod2), ~ fixef(.x)["dose", ]) %>% 
  select(Estimate, `Q2.5`, `Q97.5`) %>% 
  mutate(Model = c("Weakly informative prior", "Uniform prior")) %>% 
  bind_rows(
    tribble(
      ~ Model, ~ Estimate, ~`Q2.5`, ~`Q97.5`,
      "Frequentist linear regression",
      coef(mod3)[["dose"]],
      confint(mod3)["dose", ][[1]], 
      confint(mod3)["dose", ][[2]]
      )
  )

ggplot(plot_df, aes(x = Model, y = Estimate, ymin = `Q2.5`, ymax = `Q97.5`)) + 
  geom_point() + 
  geom_errorbar(width = .1) + 
  coord_flip()

ggsave("linear_model_comparison.png", width = 12, height = 6, units = "cm")


mcmc_dens(mod1, pars = "b_dose") +
  ggtitle("Posterior density") +
  xlab(expression(beta)) + 
  ylab("Probability")

ggsave("linear_model_posterior.png", width = 12, height = 6, units = "cm")


as_draws_df(mod1, variable = "b_dose") %>% 
  summarise(mean(b_dose > 10))

as_draws_df(mod2, variable = "b_dose") %>% 
  summarise(mean(b_dose > 10))
