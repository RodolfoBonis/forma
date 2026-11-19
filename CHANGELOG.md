# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2026-11-18

### Changes

---

Packages with breaking changes:

 - [`forma_foundation` - `v3.0.0`](#forma_foundation---v300)
 - [`forma_icons` - `v3.0.0`](#forma_icons---v300)
 - [`forma_ui` - `v3.0.0`](#forma_ui---v300)
 - [`forma_core` - `v3.0.0`](#forma_core---v300)
 - [`forma_theme_dominus` - `v3.0.0`](#forma_theme_dominus---v300)
 - [`forma_theme_plantao_facil` - `v3.0.0`](#forma_theme_plantao_facil---v300)
 - [`forma_theme_spooliq` - `v0.2.0`](#forma_theme_spooliq---v020)

Packages with other changes:

 - There are no other changes in this release.

---

#### `forma_foundation` - `v3.0.0`

 - **BREAKING** **FEAT**(foundation): migrate the theme engine to `package:material_ui/material_ui.dart` for Flutter 3.50. `ThemeData`, `ThemeExtension`, `ColorScheme` and related Material types are now sourced from `material_ui` instead of the SDK-deprecated `package:flutter/material.dart`.

#### `forma_icons` - `v3.0.0`

 - **BREAKING** **FEAT**(icons): source `IconData`/`Icons` defaults from `package:material_ui/material_ui.dart` for Flutter 3.50.

#### `forma_ui` - `v3.0.0`

 - **BREAKING** **FEAT**(ui): migrate all components to `package:material_ui/material_ui.dart` for Flutter 3.50.

#### `forma_core` - `v3.0.0`

 - **BREAKING** **FEAT**(core): re-exported Material types now come from `package:material_ui/material_ui.dart` (via forma_foundation/forma_ui) for Flutter 3.50.

#### `forma_theme_dominus` - `v3.0.0`

 - **BREAKING** **FEAT**(theme_dominus): build `ThemeData` from `package:material_ui/material_ui.dart` for Flutter 3.50.

#### `forma_theme_plantao_facil` - `v3.0.0`

 - **BREAKING** **FEAT**(theme_plantao_facil): build `ThemeData` from `package:material_ui/material_ui.dart` for Flutter 3.50.

#### `forma_theme_spooliq` - `v0.2.0`

 - **BREAKING** **FEAT**(theme_spooliq): build `ThemeData` from `package:material_ui/material_ui.dart` for Flutter 3.50.


## 2026-10-08

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`forma_foundation` - `v2.1.0`](#forma_foundation---v210)
 - [`forma_theme_spooliq` - `v0.1.1`](#forma_theme_spooliq---v011)
 - [`forma_ui` - `v2.2.0`](#forma_ui---v220)
 - [`forma_icons` - `v2.0.2`](#forma_icons---v202)
 - [`forma_core` - `v2.0.3`](#forma_core---v203)
 - [`forma_theme_plantao_facil` - `v2.0.2`](#forma_theme_plantao_facil---v202)
 - [`forma_theme_dominus` - `v2.0.2`](#forma_theme_dominus---v202)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `forma_icons` - `v2.0.2`
 - `forma_core` - `v2.0.3`
 - `forma_theme_plantao_facil` - `v2.0.2`
 - `forma_theme_dominus` - `v2.0.2`

---

#### `forma_foundation` - `v2.1.0`

 - **FEAT**(ui): desktop components, shape extension and SpoolIQ theme (#20).

#### `forma_theme_spooliq` - `v0.1.1`

 - **FEAT**(ui): desktop components, shape extension and SpoolIQ theme (#20).

#### `forma_ui` - `v2.2.0`

 - **FEAT**(ui): desktop components, shape extension and SpoolIQ theme (#20).


## 2026-06-15

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`forma_ui` - `v2.1.0`](#forma_ui---v210)
 - [`forma_core` - `v2.0.2`](#forma_core---v202)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `forma_core` - `v2.0.2`

---

#### `forma_ui` - `v2.1.0`

 - **FEAT**(ui): add FormaTextButton (#17).


## 2026-06-15

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`forma_foundation` - `v2.0.1`](#forma_foundation---v201)
 - [`forma_icons` - `v2.0.1`](#forma_icons---v201)
 - [`forma_ui` - `v2.0.1`](#forma_ui---v201)
 - [`forma_core` - `v2.0.1`](#forma_core---v201)
 - [`forma_theme_plantao_facil` - `v2.0.1`](#forma_theme_plantao_facil---v201)
 - [`forma_theme_dominus` - `v2.0.1`](#forma_theme_dominus---v201)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `forma_icons` - `v2.0.1`
 - `forma_ui` - `v2.0.1`
 - `forma_core` - `v2.0.1`
 - `forma_theme_plantao_facil` - `v2.0.1`
 - `forma_theme_dominus` - `v2.0.1`

---

#### `forma_foundation` - `v2.0.1`

 - **FIX**(foundation): wire brand text colors into Material TextTheme (#13).

# Changelog

All notable changes to the Forma Design System will be documented here.

## 1.2.0

- feat: add new Radius tokens
- docs: add detailed README with architecture, components, and theme documentation
- fix(ci): add version bump check to prevent silent release skips

## 1.1.0

- fix(ci): pass PUB_TOKEN env to publish steps
- fix(ci): simplify release workflow and add root CHANGELOG
- style: apply dart format to all packages

## 1.0.0

- Initial release with core components, tokens, and theme architecture.
