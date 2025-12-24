library(stats)

hex <- 0xDEADBEEF
sci <- 6.022e23
z   <- 2 + 3i
txt <- sprintf("hex=%x sci=%.2e z=%s", hex, sci, z)

rx  <- "\\b(if|else|for|function|return)\\b"
hit <- grepl(rx, "function f(x) return(x)")

df <- data.frame(
  id  = letters[1:4],
  val = c(1.0, NA, 3.5, 4.2),
  grp = factor(c("A","A","B","B"))
)
df$flag <- df$val > 2 | is.na(df$val)

clamp01 <- function(x) {
  ifelse(x < 0, 0, ifelse(x > 1, 1, x))
}

acc <- 0L
for (k in 1:10) {
  if (k %% 2 == 0) next
  acc <- acc + k
  if (acc > 20) break
}

out <- tryCatch({ stop("boom") }, error = function(e) e$message)
print(list(
  txt=txt, hit=hit, acc=acc,
  clamp=clamp01(c(-1, 0.2, 2)), df=df, out=out
))
