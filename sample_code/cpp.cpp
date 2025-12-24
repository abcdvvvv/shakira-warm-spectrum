// C++ syntax highlight showcase: types, templates, constexpr, RAII, lambdas,
// ranges, smart ptrs, regex, exceptions

#include <algorithm>
#include <chrono>
#include <complex>
#include <cstdint>
#include <exception>
#include <format>
#include <iostream>
#include <memory>
#include <numeric>
#include <optional>
#include <regex>
#include <string>
#include <string_view>
#include <vector>

template <class T>
concept RealLike = std::is_arithmetic_v<T>;

constexpr std::uint32_t HEX = 0xDEADBEEF;
constexpr double SCI = 6.022e23;
constexpr std::complex<double> Z{2.0, 3.0};

struct Foo final {
  double x{0.0};
  std::string tag{"warm"};
  [[nodiscard]] constexpr double sq() const noexcept { return x * x; }
};

template <RealLike T> T clamp01(T v) {
  return v < T{0} ? T{0} : (v > T{1} ? T{1} : v);
}

std::optional<std::pair<std::string, double>> parse_kv(std::string_view s) {
  static const std::regex rx(
      R"(^\s*([A-Za-z_]\w*)\s*=\s*([-+]?\d+(\.\d+)?(e[-+]?\d+)?)\s*$)",
      std::regex::icase);
  std::cmatch m{};
  if (!std::regex_match(s.begin(), s.end(), m, rx))
    return std::nullopt;
  return std::pair{std::string(m[1].str()), std::stod(m[2].str())};
}

int main() try {
  std::vector<Foo> xs;
  for (int i = 1; i <= 5; ++i)
    xs.push_back(Foo{i / 2.0, (i % 2 ? "hot" : "cold")});

  std::vector<double> v{1.0, 2e-3, 3.0, 4.0};
  auto sumsq = std::transform_reduce(v.begin(), v.end(), 0.0, std::plus<>{},
                                     [](double a) { return a * a; });

  auto kv = parse_kv("alpha=1.23e-4");
  if (!kv)
    throw std::runtime_error("bad kv");

  auto [name, val] = *kv;
  auto msg = std::format(
      "name={}, val={:.3e}, clamp01={:.3f}, HEX={:#x}, Z=({:.1f}+{:.1f}i)",
      name, val, clamp01(val * 1e5), HEX, Z.real(), Z.imag());
  std::cout << msg << "\n";

  // lambda + algorithm
  std::ranges::for_each(xs, [](const Foo &f) {
    std::cout << std::format("Foo(tag={}, x={:.2f}, sq={:.2f})\n", f.tag, f.x,
                             f.sq());
  });

  std::cout << "sumsq=" << sumsq << ", SCI=" << SCI << "\n";
  return 0;
} catch (const std::exception &e) {
  std::cerr << "caught: " << typeid(e).name() << ": " << e.what() << "\n";
  return 1;
}
