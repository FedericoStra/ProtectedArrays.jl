# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com),
and this project adheres to [Semantic Versioning](https://semver.org).

<!--
Types of changes:
- `Added` for new features;
- `Changed` for changes in existing functionality;
- `Deprecated` for soon-to-be removed features;
- `Removed` for now removed features;
- `Fixed` for any bug fixes;
- `Security` in case of vulnerabilities.
-->

## [Unreleased]

### Added

- Standard [interfaces](https://docs.julialang.org/en/v1/manual/interfaces/):
  - iteration,

## [0.1.0]

### Added

- Types `ProtectedArray`, `ProtectedMatrix`, `ProtectedVector`.
- Functions `protect`, `unprotect` to wrap and unwrap an array.

### Fixed

- Compatibility with Julia `VERSION >= v"1.8"`.
- CI.

## [0.0.0]

Empty project.

[Unreleased]: https://github.com/FedericoStra/ProtectedArrays.jl/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/FedericoStra/ProtectedArrays.jl/compare/v0.0.0...v0.1.0
[0.0.0]: https://github.com/FedericoStra/ProtectedArrays.jl/releases/tag/v0.0.0
