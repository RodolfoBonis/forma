# Forma Design System

Forma is a multi-app Flutter design system built for consistency, speed, and theming flexibility. It provides shared components, tokens, and a theme architecture that allows multiple apps to share the same visual language while maintaining their own brand identity.

## Architecture

```
forma/
├── packages/
│   ├── forma_core/                  # Components, tokens, theme engine
│   ├── forma_theme_plantao_facil/   # Plantao Facil theme variant
│   └── _template/                   # Scaffold for new themes
└── storybook/                       # Widgetbook visual documentation
```

**forma_core** provides the building blocks: buttons, inputs, cards, navigation, feedback, overlays, and a full token system (spacing, radius, typography, durations). It defines a `FormaThemeExtension` with 26 semantic color slots that theme packages fill in.

**Theme packages** (like `forma_theme_plantao_facil`) supply colors, person colors, and typography overrides for a specific brand. Creating a new theme is a single command.

## Packages

| Package | Version | Description |
|---------|---------|-------------|
| `forma_core` | 1.1.0 | Core components, tokens, and theme architecture |
| `forma_theme_plantao_facil` | 1.1.0 | Plantao Facil brand theme (Verde Floresta) |

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
| `melos run test:core` | Run tests only on forma_core |
| `melos run ci` | Run format + analyze + test |
| `melos run storybook:dev` | Run Widgetbook on Chrome |
| `melos run storybook:build` | Build Widgetbook for web |
| `melos run new:theme` | Scaffold a new theme variant |

### Storybook

The Widgetbook documents all 18 components and 5 token categories with interactive knobs:

```bash
melos run storybook:dev
```

## CI/CD

| Workflow | Trigger | What it does |
|----------|---------|--------------|
| **CI** | PR/push to `develop` | format, analyze, test |
| **Release & Publish** | push to `main` | CI check, git tags, GitHub Release, publish to private pub |

### Versioning

Packages follow [semver](https://semver.org/). To release:

1. Bump `version:` in the package's `pubspec.yaml`
2. Merge to `main`
3. The Release workflow creates tags, a GitHub Release with changelog, and publishes to the private pub server automatically

### Branch Strategy

| Branch | Purpose |
|--------|---------|
| `main` | Production releases. Merges trigger release + publish. |
| `develop` | Integration branch. CI runs on every push. |
| `feature/*` | Feature branches off `develop` |

## License

MIT
