# Forma Design System

Forma is a multi-app Flutter design system built for consistency, speed, and theming flexibility. It provides shared components, tokens, and a theme architecture that allows multiple apps to share the same visual language while maintaining their own brand identity.

## Architecture

Forma is a layered set of packages. Each layer depends only on the one below
it, so apps share a brand-agnostic base while owning their own brand and
domain widgets.

```
forma/
├── packages/
│   ├── forma_foundation/            # Tokens + theme engine + FormaThemeExtension
│   ├── forma_icons/                 # Semantic icon keys + brand SVG registry
│   ├── forma_ui/                    # Brand-agnostic UI primitives
│   ├── forma_core/                  # Compatibility facade (re-exports foundation + ui)
│   ├── forma_theme_plantao_facil/   # Plantao Facil theme variant
│   ├── forma_theme_dominus/         # Dominus theme variant
│   └── _template/                   # Scaffold for new themes
└── forma_gallery/                   # Component gallery & docs
```

Dependency direction (no cycles):

```
forma_foundation ← forma_icons ← forma_ui ← forma_theme_<brand> ← forma_gallery
```

- **forma_foundation** — design tokens (spacing, radius, typography, durations),
  the theme engine (`FormaTheme.build`), and the contracts: `FormaThemeExtension`
  (26 semantic color slots) and `FormaTypographyExtension` (a font-driven type
  scale, so each brand can ship its own typeface).
- **forma_icons** — type-safe semantic icon keys (`FormaIconKey`) backed by
  Material defaults, with a registry (`FormaIconScope`) so a brand can override
  any key with its own SVG.
- **forma_ui** — the brand-agnostic primitives (buttons, inputs, cards,
  navigation, feedback, overlays). Re-exports `forma_foundation`.
- **forma_core** — a thin compatibility facade that re-exports `forma_foundation`
  and `forma_ui`. Prefer depending on the specific layers directly.
- **Theme packages** supply a brand's colors and fonts by filling
  `FormaThemeExtension`. Creating a new theme is a single command.

App-specific (domain) components do **not** live in Forma — each app owns its
domain widgets and composes them on top of `forma_ui`.

## Packages

| Package | Description |
|---------|-------------|
| `forma_foundation` | Design tokens, theme engine, color & typography contracts |
| `forma_icons` | Semantic icon keys + brand SVG registry |
| `forma_ui` | Brand-agnostic UI primitives |
| `forma_core` | Compatibility facade re-exporting foundation + ui |
| `forma_theme_plantao_facil` | Plantao Facil brand theme (Verde Floresta) |
| `forma_theme_dominus` | Dominus brand theme (dark, wine + brass) |

Published on the private pub server at `pub.rodolfodebonis.com.br`.

## Installation

Add the private hosted dependency to your app's `pubspec.yaml`:

```yaml
dependencies:
  forma_core:
    hosted:
      name: forma_core
      url: https://pub.rodolfodebonis.com.br
    version: ^1.1.0
  forma_theme_plantao_facil:
    hosted:
      name: forma_theme_plantao_facil
      url: https://pub.rodolfodebonis.com.br
    version: ^1.1.0
```

Authenticate with the private server:

```bash
dart pub token add https://pub.rodolfodebonis.com.br
```

## Quick Start

```dart
import 'package:forma_core/forma_core.dart';
import 'package:forma_theme_plantao_facil/forma_theme_plantao_facil.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: PlantaoFacilTheme.light,
      home: Scaffold(
        appBar: FormaAppHeader(title: 'Home', variant: FormaAppHeaderVariant.titleOnly),
        body: Column(
          children: [
            FormaButton(label: 'Confirmar', variant: FormaButtonVariant.primary, onPressed: () {}),
            FormaBadge(label: 'Confirmada', variant: FormaBadgeVariant.confirmada),
            FormaTextField(label: 'Nome', hint: 'Digite seu nome'),
          ],
        ),
        bottomNavigationBar: FormaBottomNav(
          activeIndex: 0,
          onTap: (i) {},
          items: [
            FormaNavItem(icon: Icons.home, label: 'Home'),
            FormaNavItem(icon: Icons.calendar_today, label: 'Calendario'),
          ],
        ),
      ),
    );
  }
}
```

## Components

### Buttons
| Component | Description |
|-----------|-------------|
| `FormaButton` | Action button with variants: primary, secondary, danger, ghost, whatsApp, disabled. Supports loading state. |
| `FormaIconButton` | Icon button with proper 48px touch target sizing |

### Inputs
| Component | Description |
|-----------|-------------|
| `FormaTextField` | Text field with label, hint, validation, prefix/suffix, obscureText |
| `FormaTimePicker` | Time picker field that opens the system time picker on tap |

### Display
| Component | Description |
|-----------|-------------|
| `FormaAvatar` | Colored circle with initial letter. Sizes: small (36), medium (44), large (56) |
| `FormaBadge` | Status pill with semantic colors: confirmada, pendente, cancelada, oficial, aoVivo, aguardando, ativo |
| `FormaCard` | Themed card container with variants: basic, heroDark, swap, shift |
| `FormaModeToggle` | Two-option segmented toggle (e.g. "Com aprovacao" / "Acordo direto") |
| `FormaPersonChip` | Person chip with avatar initial and name, active/inactive states |
| `FormaTimeline` | Event timeline with titled steps and timing labels |
| `FormaWhatsAppPreview` | WhatsApp message preview with green header and bubble |

### Navigation
| Component | Description |
|-----------|-------------|
| `FormaAppHeader` | Top app bar with variants: withBack, titleOnly, custom |
| `FormaBottomNav` | Bottom navigation bar with active indicator dots |

### Feedback
| Component | Description |
|-----------|-------------|
| `FormaAlertBanner` | Alert banner with variants: success, warning, error, info, urgency |
| `FormaLoading` | Centered adaptive circular progress indicator |
| `FormaPushNotification` | Push notification preview banner with app icon and message |
| `FormaUrgencyHeader` | Urgency banner with title and subtitle on urgency-colored background |

### Overlay
| Component | Description |
|-----------|-------------|
| `FormaBottomSheet` | Draggable modal bottom sheet with drag handle and optional title |
| `FormaStepIndicator` | Horizontal step progress bar with "Passo N de M" label |

## Design Tokens

### Spacing

| Token | Value | Usage |
|-------|-------|-------|
| `FormaSpacing.xs` | 4px | Tight gaps |
| `FormaSpacing.sm` | 8px | Small gaps |
| `FormaSpacing.md` | 12px | Medium gaps |
| `FormaSpacing.base` | 16px | Default spacing |
| `FormaSpacing.lg` | 20px | Large gaps |
| `FormaSpacing.xl` | 24px | Section spacing |
| `FormaSpacing.xxl` | 32px | Large section spacing |
| `FormaSpacing.xxxl` | 40px | Extra large spacing |
| `FormaSpacing.huge` | 48px | Maximum spacing |

### Border Radius

| Token | Value | Usage |
|-------|-------|-------|
| `FormaRadius.subtle` | 4px | Inline elements |
| `FormaRadius.input` | 8px | Input fields |
| `FormaRadius.small` | 12px | Small containers |
| `FormaRadius.card` | 16px | Default cards |
| `FormaRadius.button` | 18px | Buttons |
| `FormaRadius.cardLg` | 20px | Large cards |
| `FormaRadius.large` | 22px | Large containers |
| `FormaRadius.chip` | 24px | Chips and pills |
| `FormaRadius.sheet` | 28px | Bottom sheets |

### Typography

| Style | Size | Weight |
|-------|------|--------|
| `displayHero` | 52px | Bold |
| `h1` | 34px | Bold |
| `h2` | 26px | Bold |
| `h3` | 22px | Bold |
| `h4` | 20px | Bold |
| `title18` | 18px | Bold |
| `title16` | 16px | Bold |
| `body16` | 16px | Regular |
| `body14` | 14px | Regular |
| `body14Medium` | 14px | Medium |
| `body13` | 13px | Regular |
| `caption12` | 12px | Regular |
| `overline10` | 10px | Medium |

### Durations

| Token | Value | Usage |
|-------|-------|-------|
| `FormaDurations.fade` | 220ms | Quick fade/opacity transitions |
| `FormaDurations.smart` | 280ms | Standard UI transitions |
| `FormaDurations.slow` | 400ms | Deliberate transitions (page changes) |

## Theming

### FormaThemeExtension

The theme extension exposes 26 semantic color properties:

```
appBackground, cardBackground,
primaryColor, primarySurface, primaryBorder,
secondaryColor, secondarySurface,
accentColor, accentSurface,
textPrimary, textMuted, textHint,
border, borderStrong,
successColor, successSurface, successText,
warningColor, warningSurface, warningText,
urgencySurface,
errorColor, errorSurface, errorText,
infoSurface, infoText
```

### Creating a New Theme

```bash
melos run new:theme -- --name=mybrand
```

This scaffolds a new package under `packages/forma_theme_mybrand/` with color tokens and a theme file ready to customize.

## Development

### Prerequisites

- Flutter >= 3.41.0
- Dart >= 3.11.0
- Melos (`dart pub global activate melos`)

### Setup

```bash
git clone git@github.com:RodolfoBonis/forma.git
cd forma
melos bootstrap
```

### Commands

| Command | Description |
|---------|-------------|
| `melos run format` | Format all packages |
| `melos run analyze` | Analyze all packages |
| `melos run test` | Run tests across all packages |
| `melos run ci` | Run format + analyze + test |
| `melos run gallery:dev` | Run the gallery on Chrome |
| `melos run gallery:build` | Build the gallery for web |
| `melos run new:theme` | Scaffold a new theme variant |

### Gallery

`forma_gallery` documents every component and token category with interactive
knobs, theme switching, and per-component docs:

```bash
melos run gallery:dev
```

## CI/CD

| Workflow | Trigger | What it does |
|----------|---------|--------------|
| **CI** | PR to `develop`/`main`, push to `develop` | format, analyze, test (cached) |
| **Release · Prepare** | manual | cut a `release/*` branch, `melos version` (independent bump + changelogs), open a review PR to `main` |
| **Release · Publish** | manual | CI gate → publish only the changed packages (RC or final) → fast-forward `main` + `develop` |
| **Gallery Deploy** | a (final) GitHub Release is published | build & deploy `forma_gallery` to GitHub Pages |

Packages are **versioned independently** (via `melos version`): only the
packages that changed (and their dependents) are bumped and published. The
publish step skips any version already on the server, so unchanged packages are
never re-published.

### Release flow (two phases)

PRs land on `develop` (squash-merge, Conventional Commits title — the title
drives the per-package bump). A release goes out in two phases, and `main` is
always a fast-forward mirror of the released `develop` (no divergence).

1. **Prepare** — Actions → **Release · Prepare** → Run workflow (on `develop`).
   Cuts `release/<label>`, runs `melos version` (bumps only the changed packages
   + dependents, updates changelogs), and opens a PR `release/<label> → main`
   for review.
2. **Publish RC** *(optional, repeatable)* — Actions → **Release · Publish** with
   `pre_release = true`. Publishes the changed packages as `x.y.z-rc.N` (a
   pre-release) so apps can install and QA them. Does not touch `main`/`develop`.
   RC consumers must pin the exact `x.y.z-rc.N` (a `^x.y.z` constraint won't pick
   up a pre-release).
3. **Finalize** — Actions → **Release · Publish** with `pre_release = false`.
   Publishes the final versions, then fast-forwards **both** `main` and
   `develop` to the release commit and deletes the release branch.

Both phases accept `dry_run` to validate without side effects.

### Branch Strategy

| Branch | Purpose |
|--------|---------|
| `main` | Released state. Updated **only** by the release workflow (fast-forward). No direct pushes/PRs. |
| `develop` | Integration / next release. PRs target this branch; CI runs on every push. |
| `release/*` | Short-lived release/freeze branch (one at a time). Reviewed via PR to `main`, then promoted by fast-forward. |
| `feature/*` | Feature branches off `develop` |

**Freeze:** avoid merging to `develop` while a `release/*` branch is open — the
finalize step fast-forwards `develop`, which requires it not to have moved since
the cut. Hotfixes also go through `develop` so `main` stays fast-forward-only.

## License

MIT
