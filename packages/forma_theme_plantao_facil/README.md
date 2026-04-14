# forma_theme_plantao_facil

Plantao Facil theme variant for the [Forma Design System](../../README.md). Provides the Verde Floresta color palette, person colors, and a pre-built `ThemeData` for the Plantao Facil app.

## Installation

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

## Usage

```dart
import 'package:forma_theme_plantao_facil/forma_theme_plantao_facil.dart';

MaterialApp(
  theme: PlantaoFacilTheme.light,
  home: MyHomePage(),
)
```

## Color Palette

### Primary — Verde Floresta

| Token | Hex | Usage |
|-------|-----|-------|
| `PfColors.primary900` | `#0D5238` | Dark accent |
| `PfColors.primary700` | `#1A6B4A` | Main primary, CTAs, active states |
| `PfColors.primary500` | `#2D8A64` | Mid primary |
| `PfColors.primary200` | `#B8E0CD` | Borders, light accents |
| `PfColors.primary50` | `#DCF0E7` | Surface backgrounds |

### Secondary — Indigo

| Token | Hex | Usage |
|-------|-----|-------|
| `PfColors.secondary700` | `#3D3399` | Dark secondary |
| `PfColors.secondary500` | `#5549C8` | Main secondary, info |
| `PfColors.secondary200` | `#C9C5EF` | Light secondary |
| `PfColors.secondary50` | `#ECEAF9` | Surface backgrounds |

### Accent — Terracota

| Token | Hex | Usage |
|-------|-----|-------|
| `PfColors.accent700` | `#9E3E18` | Dark accent |
| `PfColors.accent500` | `#C45422` | Main accent |
| `PfColors.accent200` | `#F3CEAD` | Light accent |
| `PfColors.accent50` | `#FAEADE` | Surface backgrounds |

### Neutrals

| Token | Hex | Usage |
|-------|-----|-------|
| `neutral900` | `#0F0F0F` | Primary text |
| `neutral600` | `#6B6560` | Muted text |
| `neutral400` | `#9B9693` | Placeholders, hints |
| `neutral200` | `#E8E4DC` | Borders |
| `neutral100` | `#F5F3EF` | Card backgrounds |
| `neutral50` | `#F0ECE4` | App background |
| `white` | `#FFFFFF` | Pure white |

### Semantic

| Token | Hex | Usage |
|-------|-----|-------|
| `success` / `successSurface` | `#1A6B4A` / `#D4EDDA` | Success states |
| `warning` / `warningSurface` | `#E8B84B` / `#FFF3CC` | Warning states |
| `error` / `errorSurface` | `#C0392B` / `#FDDEDE` | Error states |
| `infoSurface` | `#ECEAF9` | Informational states |
| `urgencySurface` | `#FFF8E8` | High-priority items |

### Brand

| Token | Hex | Usage |
|-------|-----|-------|
| `whatsApp` | `#25D366` | WhatsApp button |
| `whatsAppDark` | `#128C7E` | WhatsApp header |

## Person Colors

Each team member gets a distinct hue with a light surface variant for avatars, chips, and highlights:

| Person | Main | Surface | Hue |
|--------|------|---------|-----|
| Ana | `#1A6B4A` | `#DCF0E7` | Primary green |
| Diogenes | `#5549C8` | `#ECEAF9` | Secondary indigo |
| Augusto | `#C45422` | `#FAEADE` | Accent terracota |

```dart
import 'package:forma_theme_plantao_facil/forma_theme_plantao_facil.dart';

FormaPersonChip(
  initial: 'A',
  name: 'Ana',
  color: PfPersonColors.ana,
  surfaceColor: PfPersonColors.anaSurface,
  isActive: true,
)
```

## Theme Mapping

`PlantaoFacilTheme.light` maps `PfColors` to the 26 `FormaThemeExtension` slots:

| Slot | Color |
|------|-------|
| `appBackground` | `neutral50` |
| `cardBackground` | `white` |
| `primaryColor` | `primary700` |
| `primarySurface` | `primary50` |
| `primaryBorder` | `primary200` |
| `secondaryColor` | `secondary500` |
| `secondarySurface` | `secondary50` |
| `accentColor` | `accent500` |
| `accentSurface` | `accent50` |
| `textPrimary` | `neutral900` |
| `textMuted` | `neutral600` |
| `textHint` | `neutral400` |
| `border` | `neutral200` |
| `borderStrong` | `neutral400` |
| `successColor` | `success` |
| `warningColor` | `warning` |
| `errorColor` | `error` |
| `urgencySurface` | `urgencySurface` |

Font family: **Inter**
Seed color: `primary700` (`#1A6B4A`)

## License

MIT
