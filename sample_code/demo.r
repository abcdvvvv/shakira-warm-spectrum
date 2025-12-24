# OLS + robust SE (HC1) + bootstrap CI
set.seed(42)
n <- 400
x1 <- rnorm(n)
x2 <- 0.6 * x1 + rnorm(n, sd = 0.8)
eps <- rnorm(n, sd = 0.3 + 0.8 * abs(x1))
y <- 1 + 2 * x1 - 1.2 * x2 + eps
df <- data.frame(y, x1, x2)

fit <- lm(y ~ x1 + x2, data = df)
print(coef(fit))

X <- model.matrix(fit)
e <- residuals(fit)
p <- ncol(X)
XtX_inv <- solve(crossprod(X))
meat <- crossprod(X * e) # X' diag(e^2) X
V_hc1 <- (n / (n - p)) * XtX_inv %*% meat %*% XtX_inv
se_hc1 <- sqrt(diag(V_hc1))
cat("HC1 SE:\n")
print(setNames(se_hc1, colnames(X)))

B <- 500
b1 <- numeric(B)
for (b in 1:B) {
    idx <- sample.int(n, n, replace = TRUE)
    b1[b] <- coef(lm(y ~ x1 + x2, data = df[idx, ]))["x1"]
}
ci <- quantile(b1, c(0.025, 0.975))
cat("Bootstrap CI (x1):\n")
print(ci)

h <- hatvalues(fit)
r <- rstandard(fit)
cat("max leverage=", max(h), " max |r|=", max(abs(r)), "\n")
