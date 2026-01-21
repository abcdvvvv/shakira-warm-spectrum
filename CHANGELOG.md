# Change Log

All notable changes to the "shakira-warm-spectrum" extension will be documented in this file.

Check [Keep a Changelog](http://keepachangelog.com/) for recommendations on how to structure this file.

## [0.4.1] - 2026-01-21

### Changed

- R: updated other operator color (`keyword.other.r`).
- Consolidated function definition/call scopes to include MATLAB and C++ rules.
- Unified function argument/parameter scopes for R/Python and folded C++ parameter types into the shared type rule.
- Adopted a shared relational-operator rule, now covering JS/TS comparison/ternary operators.

## [0.4.0] - 2026-01-18

### Added

- C++ syntax highlighting support (types, modifiers, and keywords).
- Constants (Inf/NaN/NA) highlighting across Julia/R/Python.
- Python: highlight inherited classes in class definitions.

### Changed

- Synced dark/light rule sets and refreshed reference scope groups for consistency.
- Expanded token scope coverage for function calls, types, and punctuation.

## [0.3.0] - 2026-01-07

### Added

- Julia: highlight `keyword.operator.relation.types.julia` and `keyword.operator.bitwise.julia`.
- Python: added comparison operator highlighting and `self` parameter highlighting.
- Added JavaScript/TypeScript/TSX/JSX language support.

### Changed

- Updated semantic token palette (including `parameter`) for better consistency across languages.

## [0.2.0] - 2025-12-28

### Added

- MATLAB syntax highlighting rules for both themes (function calls/declarations, parameters, relational/logical operators, and `if` blocks).

## [0.1.5] - 2025-12-27

### Changed

- Dark theme: added `sideBar.border` for clearer sidebar separation.
- Dark theme: adjusted JSON key nesting colors (alternating neutral + cyan) for readability.
- Light theme: adjusted JSON key nesting colors (alternating neutral + blue) for readability.
- Repo: mark `sample_code/` as vendored for GitHub linguist.

## [0.1.4] - 2025-12-24

### Changed

- Light theme: refreshed the number/orange accent from `#D2691E` to `#e77b00`.
- Added `Julia / R - assignment operators` rule (Julia `->`/`=>` and R `<-`), keeping dark/light token sets aligned.
- R: keep function-call argument `=` neutral via `R - function-call assignment (=)` so `<-` can be highlighted independently.

## [0.1.3] - 2025-12-24

### Changed

- Improved Julia docstring styling (triple quotes and embedded code blocks).
- Updated JSON key nesting colors for better readability.
- Refined C++ token colors and kept dark/light rules aligned.

## [0.1.2] - 2025-12-24

### Changed

- Lowered the minimum VS Code version requirement to `^1.60.0`.

## [0.1.1] - 2025-12-24

### Fixed

- Packaging: exclude unnecessary development artifacts from the published VSIX.

## [0.1.0] - 2025-12-24

### Added

- Language-specific highlighting rules for Python and R (in addition to Julia).

### Changed

- Improved token rule organization and kept dark/light rule sets aligned.
- Updated README with multi-language screenshots (Julia/Python/R).

## [0.0.3]

### Changed

- Updated extension icon.

## [0.0.2]

### Added

- Initial release.
