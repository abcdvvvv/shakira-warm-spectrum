# Logistic Regression (NumPy) with mini-batch SGD
import numpy as np

def sigmoid(z: np.ndarray) -> np.ndarray:
    z = np.clip(z, -30.0, 30.0)
    return 1.0 / (1.0 + np.exp(-z))

def make_data(n: int = 2000, d: int = 8, seed: int = 0):
    rng = np.random.default_rng(seed)
    X = rng.normal(size=(n, d))
    w_true = rng.normal(size=(d,))
    logits = X @ w_true + 0.5 * rng.normal(size=n)
    y = (logits > 0.0).astype(np.float64)          # labels in {0,1}
    X = (X - X.mean(0)) / (X.std(0) + 1e-12)       # standardize
    return X, y

def train_logreg_sgd(X, y, lr=0.2, l2=1e-2, steps=800, batch=128, seed=0):
    rng = np.random.default_rng(seed)
    n, d = X.shape
    w = np.zeros(d, dtype=np.float64)
    b = 0.0

    for t in range(steps):
        idx = rng.integers(0, n, size=batch)
        Xb, yb = X[idx], y[idx]
        p = sigmoid(Xb @ w + b)
        gw = (Xb.T @ (p - yb)) / batch + l2 * w
        gb = float(np.mean(p - yb))
        w -= lr * gw
        b -= lr * gb
        if (t + 1) % 200 == 0:
            pred = (sigmoid(X @ w + b) >= 0.5).astype(np.float64)
            acc = float(np.mean(pred == y))
            loss = float(np.mean(-(y*np.log(p+1e-12) + (1-y)*np.log(1-p+1e-12))))
            print(f"step={t+1:4d}  loss≈{loss:.4f}  acc={acc:.3f}")

    return w, b

# if __name__ == "__main__":
#     X, y = make_data()
#     w, b = train_logreg_sgd(X, y)
#     print("final |w|=", float(np.linalg.norm(w)), "b=", b)
