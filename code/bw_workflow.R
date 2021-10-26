library(tidyverse)
theme_set(theme_bw())
library(latex2exp)
library(brms)
library(bayesplot)
library(BayesMallows)
dat <- readRDS("data/bwt.rds")

mod <- brm(Low ~ LWT, data = dat, family = bernoulli(),
           prior = set_prior("normal(0, 0.4)", "b", coef = "LWT"))


mcmc_hist(mod, pars = "b_LWT", binwidth = .002)
ggsave("figures/posterior_example.png", width = 6, height = 6, units = "cm")



mcmc_trace(mod, pars = "b_LWT")
ggsave("figures/trace_plot_example.png", width = 12, height = 6, units = "cm")


models <- compute_mallows(rankings = sushi_rankings, nmc = 4000, alpha_jump = 10)
assess_convergence(models)
ggsave("figures/bad_trace_plot_example.png", width = 12, height = 6, units = "cm")
rm(models)


pp_check(mod, ndraws = 100, type = "bars")
ggsave("figures/pp_bar_example.png", width = 8, height = 6, units = "cm")

pp_check(mod, ndraws = 9, type = "error_binned")
ggsave("figures/pp_error_binned_example.png", width = 12, height = 8, units = "cm")

mod2 <- brm(Low ~ LWT + Smoker, data = dat, family = bernoulli(),
            prior = set_prior("normal(0, 0.4)", "b", coef = "LWT"))

waic(mod, mod2, model_names = c("LWT", "LWT+Smoker"))
loo_compare(loo(mod), loo(mod2))

