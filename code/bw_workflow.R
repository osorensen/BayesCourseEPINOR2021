library(tidyverse)
theme_set(theme_bw())
library(latex2exp)
dat <- readRDS("data/bwt.rds")

# Prior simulations
n_draws <- 100

crossing(
  delta_w = seq(from = -10, to = 10, by = 1),
  beta_lwt = rnorm(n_draws)
) %>% 
  mutate(
    odds_ratio = exp(delta_w * beta_lwt)
  ) %>% 
  ggplot(aes(x = delta_w, y = odds_ratio, group = factor(beta_lwt), color = beta_lwt)) + 
  geom_line() +
  scale_y_log10()
