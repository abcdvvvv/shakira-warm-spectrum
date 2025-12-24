###############################################################################
# R Syntax Highlight Showcase
# - Keywords: if/else, for/while, repeat, break/next, tryCatch, function, return
# - Numbers: int/float/scientific/hex/complex/Inf/NaN
# - Strings: single/double, escapes, paste/glue-like sprintf, regex
# - Data: vectors, lists, data.frame, tibble-ish printing, factors, dates
# - Ops: <-, =, ::, :::, $, [[ ]], %, %in%, %, |>, + - * / ^, %% %/%
# - Base + tidy style, S3, attributes, environments
###############################################################################

# Packages (namespaces trigger '::')
# install.packages(c("stats", "utils"))  # usually available
stats::setNames(1:3, c("a", "b", "c"))

# -----------------------------
# Literals / constants / NA zoo
# -----------------------------
i_int     <- 42L
x_float   <- 3.141592653589793
x_sci     <- 6.022e23
x_neg_sci <- -1e-9
x_hex     <- 0xDEADBEEF
x_complex <- 2 + 3i
x_special <- c(Inf, -Inf, NaN, NA, NA_integer_, NA_real_, NA_character_, NA_complex_)

# Strings, escapes, raw-ish via single quotes, and sprintf formatting
s1 <- "Hello\tR\n\"quotes\" and unicode: \u03bb"
s2 <- 'single-quoted string'
s3 <- sprintf("pi=%.3f, sci=%.2e, hex=%x", x_float, x_sci, x_hex)

# Regex (common highlighting)
rx <- "\\b(?:if|else|for|while|function|return)\\b"
grepl(rx, "function f(x) return(x)")

# -----------------------------
# Vectors / seq / indexing / ops
# -----------------------------
v <- c(1, 2, 3, 4, 5)
w <- seq(from = 0, to = 1, length.out = 6)
m <- matrix(1:9, nrow = 3, byrow = TRUE)
v2 <- v[v %% 2 == 1]                 # logical indexing
m2 <- m[, 1]                         # slicing
in_set <- v %in% c(2, 4, 6)           # %in% operator

# Pipe (base R 4.1+)
pipe_demo <- v |>
  (\(x) x^2)() |>
  mean()

# -----------------------------
# Lists / data.frame / factor / dates
# -----------------------------
lst <- list(
  nums = v,
  txt  = c("a", "b", "c"),
  mat  = m,
  meta = list(tag = "demo", scale = 0.75)
)

df <- data.frame(
  id    = letters[1:5],
  value = c(1.0, 2.5, NA, 4.0, 5.5),
  grp   = factor(c("A", "A", "B", "B", "B")),
  when  = as.Date("2025-01-01") + 0:4,
  stringsAsFactors = FALSE
)

df$value_z <- scale(df$value)         # NA propagates
df$flag    <- df$value > 3 | is.na(df$value)

# -----------------------------
# Functions / closures / defaults / ...
# -----------------------------
clamp01 <- function(x, lo = 0, hi = 1) {
  x <- pmax(lo, pmin(hi, x))
  return(x)
}

summarize_vec <- function(x, ..., na.rm = TRUE) {
  list(
    mean = mean(x, ..., na.rm = na.rm),
    sd   = sd(x, na.rm = na.rm),
    min  = min(x, na.rm = na.rm),
    max  = max(x, na.rm = na.rm)
  )
}

# Anonymous function + apply family
row_sums <- apply(m, 1, function(row) sum(row^2))

# -----------------------------
# Control flow: if/else, loops, break/next, repeat
# -----------------------------
acc <- 0
for (k in 1:10) {
  if (k %% 2 == 0) next
  acc <- acc + k
  if (acc > 20) break
}

j <- 0
while (j < 3) {
  j <- j + 1
}

repeat {
  if (j >= 3) break
}

# -----------------------------
# Error handling: try/tryCatch
# -----------------------------
safe_div <- function(a, b) {
  tryCatch(
    a / b,
    warning = function(w) { message("warning: ", conditionMessage(w)); NA_real_ },
    error   = function(e) { message("error: ",   conditionMessage(e)); NA_real_ },
    finally = { invisible(NULL) }
  )
}

bad <- safe_div(1, 0)

# -----------------------------
# Environments / attributes
# -----------------------------
env <- new.env(parent = emptyenv())
env$x <- 123
attr(v, "note") <- "vector attribute demo"
class(df) <- c("DemoDF", class(df))

# S3 method highlighting (generic + method)
print.DemoDF <- function(x, ...) {
  cat("<DemoDF>\n")
  NextMethod("print")
}

# -----------------------------
# Plot calls (often highlighted differently)
# -----------------------------
op <- par(mfrow = c(1, 2))
plot(w, clamp01(w + rnorm(length(w), sd = 0.05)),
     type = "b", main = "Clamp + Noise", xlab = "w", ylab = "clamp01(w+noise)")
hist(na.omit(df$value), breaks = 5, main = "Histogram", xlab = "value")
par(op)

# -----------------------------
# Final prints (to see objects)
# -----------------------------
cat("pipe_demo=", pipe_demo, "\n")
print(summarize_vec(df$value))
print(df)
print(lst)
print(env$x)
