library(brms)
library(latex2exp)
library(bayesplot)
library(tidyverse)
library(glue)
theme_set(theme_classic())

# Model with weakly informative prior
mod1 <- brm(len ~ dose, data = ToothGrowth, 
            prior = prior_string("normal(0, 30)", class = "b", coef = "dose"))

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
  coord_flip() + 
  xlab("")

ggsave("figures/linear_model_comparison.png", width = 12, height = 6, units = "cm")

dens <- as_draws_df(mod1, variable = "b_dose")$b_dose %>% 
  density()

plot_df <- tibble(x = dens$x, y = dens$y)

ggplot(plot_df, aes(x = x, y = y)) + 
  geom_line() + 
  xlab(expression(beta)) +
  ylab(latex2exp::TeX("$p(\\beta | data)$")) +
  ggtitle(latex2exp::TeX("Posterior for $\\beta$"))
  
ggsave("figures/linear_model_posterior.png", width = 8, height = 6, units = "cm")

plot_df %>% 
  summarise(sum(y[x > 10]) / sum(y))

ggplot(plot_df, aes(x = x, y = y)) + 
  geom_line() + 
  geom_area(data = filter(plot_df, x > 10), fill = "blue", alpha = .5) +
  geom_text(data = tibble(x = 10.6, y = .1, label = "40%"), aes(x = x, y = y, label = label),
            color = "white") +
  xlab(expression(beta)) +
  ylab(latex2exp::TeX("$p(\\beta | data)$")) +
  ggtitle(latex2exp::TeX("Posterior for $\\beta$"))

ggsave("figures/linear_model_posterior_gt10.png", width = 8, height = 6, units = "cm")

# Rerun with less data
mod1a <- brm(len ~ dose, data = ToothGrowth[sample(nrow(ToothGrowth), 10), ], 
             prior = prior_string("normal(0, 30)", class = "b", coef = "dose"))

mod1b <- brm(len ~ dose, data = ToothGrowth[sample(nrow(ToothGrowth), 30), ], 
             prior = prior_string("normal(0, 30)", class = "b", coef = "dose"))

mod1c <- brm(len ~ dose, data = ToothGrowth[sample(nrow(ToothGrowth), 50), ], 
             prior = prior_string("normal(0, 30)", class = "b", coef = "dose"))

posteriors_df <- imap_dfr(list("n = 10" = mod1a, "n = 30" = mod1b, 
                               "n = 50" = mod1c, "full" = mod1), function(model, label){
  dens <- as_draws_df(model, variable = "b_dose")$b_dose %>% 
    density()
  
  tibble(x = dens$x, y = dens$y, label = label)
})

plot_df <- posteriors_df %>% 
  bind_rows(
    tibble(x = seq(from = -10, to = max(posteriors_df$x), length.out = 100)) %>% 
      mutate(y = dnorm(x, sd = 30), label = "prior")
  ) %>% 
  mutate(
    label = factor(label, levels = c("prior", "n = 10", "n = 30", "n = 50", "full"))
  )

walk(seq_along(levels(plot_df$label)), function(i){
  plot_df %>% 
    filter(as.integer(label) <= i) %>% 
    ggplot(aes(x = x, y = y, group = label, color = label)) + 
    geom_line() +
    xlab(expression(beta)) +
    ylab(latex2exp::TeX("$p(\\beta | data)$")) +
    ggtitle(latex2exp::TeX("The effect of adding data")) +
    labs(color = NULL)
  
  ggsave(glue("figures/linreg_increment_{i}.png"), height = 6, width = 8, units = "cm")
})


