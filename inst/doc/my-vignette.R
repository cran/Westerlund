## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----fig.width=6, fig.height=4------------------------------------------------
library(Westerlund)

# 1. Generate a small synthetic panel dataset
set.seed(123)
N <- 10; T <- 30
df <- data.frame(
  id = rep(1:N, each = T),
  time = rep(1:T, N),
  y = rnorm(N * T),
  x1 = rnorm(N * T)
)

# 2. Run Asymptotic (Plain) Test
res_plain <- westerlund_test(
  data = df, yvar = "y", xvars = "x1",
  idvar = "id", timevar = "time",
  constant = TRUE, lags = 1, leads = 0,
  verbose = FALSE
)
print(res_plain)

# 3. Run Bootstrap Test with automatic lag selection
# Note: bootstrap replications are kept low for example purposes
res_boot <- westerlund_test(
  data = df, yvar = "y", xvars = "x1",
  idvar = "id", timevar = "time",
  constant = TRUE, lags = c(0, 1),
  bootstrap = 50, seed = 123, verbose = FALSE
)

# 4. Inspect the full result summary
summary(res_boot)

# 5. Visualize the Bootstrap Results
p <- plot(
  res_boot,
  conf_level = 0.05,
  show_robust_p = TRUE
)

print(p)

