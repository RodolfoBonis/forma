# forma_core

Core package of the Forma Design System. Provides shared Flutter components, design tokens, and theme architecture for multi-app consistency.

## Installation

```yaml
dependencies:
  forma_core:
    hosted:
      name: forma_core
      url: https://pub.rodolfodebonis.com.br
    version: ^1.1.0
```

## Usage

```dart
import 'package:forma_core/forma_core.dart';
```

All components read their colors from `FormaThemeExtension`, so you must apply a theme that provides it (e.g. `forma_theme_plantao_facil`).

## Components

### Buttons

**FormaButton** — Action button with loading state support.

```dart
FormaButton(
  label: 'Confirmar',
  variant: FormaButtonVariant.primary,
  onPressed: () {},
)
```

Variants: `primary`, `secondary`, `danger`, `ghost`, `whatsApp`, `disabled`

**FormaIconButton** — Icon button with 48px touch target.

```dart
FormaIconButton(
  icon: Icon(Icons.arrow_back),
  onPressed: () {},
)
```

### Inputs

**FormaTextField** — Themed text field with label, hint, and validation.

```dart
FormaTextField(
  label: 'Email',
  hint: 'nome@exemplo.com',
  validator: (v) => v!.isEmpty ? 'Obrigatorio' : null,
)
```

**FormaTimePicker** — Opens the system time picker on tap.

```dart
FormaTimePicker(
  label: 'Horario',
  value: TimeOfDay(hour: 8, minute: 0),
  onChanged: (time) {},
)
```

### Display

**FormaAvatar** — Colored circle with initial letter.

```dart
FormaAvatar(initial: 'A', color: Colors.green, size: FormaAvatarSize.medium)
```

**FormaBadge** — Status pill with semantic colors.

```dart
FormaBadge(label: 'Confirmada', variant: FormaBadgeVariant.confirmada)
```

Variants: `confirmada`, `pendente`, `cancelada`, `oficial`, `aoVivo`, `aguardando`, `ativo`

**FormaCard** — Themed card container.

```dart
FormaCard(
  variant: FormaCardVariant.basic,
  child: Text('Content'),
)
```

Variants: `basic`, `heroDark`, `swap` (accent left border), `shift` (selectable)

**FormaModeToggle** — Two-option segmented toggle.

```dart
FormaModeToggle(
  options: ['Com aprovacao', 'Acordo direto'],
  selectedIndex: 0,
  onChanged: (index) {},
)
```

**FormaPersonChip** — Person chip with avatar and name.

```dart
FormaPersonChip(
  initial: 'A',
  name: 'Ana',
  color: PfPersonColors.ana,
  surfaceColor: PfPersonColors.anaSurface,
  isActive: true,
)
```

**FormaTimeline** — Event timeline with steps and timing.

```dart
FormaTimeline(
  title: 'O que acontece agora',
  steps: [
    FormaTimelineStep(label: 'Solicitacao enviada', timing: 'Imediato'),
    FormaTimelineStep(label: 'Notificacao recebida', timing: 'Em segundos'),
  ],
)
```

**FormaWhatsAppPreview** — WhatsApp message preview.

```dart
FormaWhatsAppPreview(message: 'Rodolfo te convidou! Clique: ...')
```

### Navigation

**FormaAppHeader** — Top app bar.

```dart
FormaAppHeader(
  title: 'Titulo da tela',
  variant: FormaAppHeaderVariant.withBack,
  onBack: () => Navigator.pop(context),
)
```

Variants: `withBack`, `titleOnly`, `custom`

**FormaBottomNav** — Bottom navigation bar with active dots.

```dart
FormaBottomNav(
  activeIndex: 0,
  onTap: (i) {},
  items: [
    FormaNavItem(icon: Icons.home, label: 'Inicio'),
    FormaNavItem(icon: Icons.calendar_today, label: 'Calendario'),
    FormaNavItem(icon: Icons.swap_horiz, label: 'Trocas'),
    FormaNavItem(icon: Icons.download, label: 'Exportar'),
  ],
)
```

### Feedback

**FormaAlertBanner** — Alert banner with icon and message.

```dart
FormaAlertBanner(message: 'Operacao concluida.', variant: FormaAlertVariant.success)
```

Variants: `success`, `warning`, `error`, `info`, `urgency`

**FormaLoading** — Centered circular progress indicator.

```dart
FormaLoading(size: 24, strokeWidth: 2.5)
```

**FormaPushNotification** — Push notification preview.

```dart
FormaPushNotification(
  appName: 'Plantao Facil',
  body: 'Ana quer trocar seu plantao de amanha.',
  timestamp: 'agora',
)
```

**FormaUrgencyHeader** — Urgency banner.

```dart
FormaUrgencyHeader(
  title: 'Solicitacao de troca recebida',
  subtitle: 'Responda para confirmar o acordo.',
)
```

### Overlay

**FormaBottomSheet** — Modal bottom sheet with drag handle.

```dart
FormaBottomSheet.show(
  context: context,
  title: 'Titulo da acao',
  child: MyContent(),
)
```

**FormaStepIndicator** — Horizontal step progress.

```dart
FormaStepIndicator(currentStep: 2, totalSteps: 4)
```

## Design Tokens

### Spacing (`FormaSpacing`)

| Token | Value |
|-------|-------|
| `xs` | 4px |
| `sm` | 8px |
| `md` | 12px |
| `base` | 16px |
| `lg` | 20px |
| `xl` | 24px |
| `xxl` | 32px |
| `xxxl` | 40px |
| `huge` | 48px |

### Border Radius (`FormaRadius`)

| Token | Value | Usage |
|-------|-------|-------|
| `subtle` | 4px | Inline elements |
| `input` | 8px | Input fields |
| `small` | 12px | Small containers |
| `card` | 16px | Default cards |
| `button` | 18px | Buttons |
| `cardLg` | 20px | Large cards |
| `large` | 22px | Large containers |
| `chip` | 24px | Chips, pills |
| `sheet` | 28px | Bottom sheets |
| `appIcon` | 54px | App icons |

### Typography (`FormaTypography`)

| Style | Size | Weight |
|-------|------|--------|
| `displayHero` | 52px | Bold |
| `h1` – `h4` | 34–20px | Bold |
| `title18`, `title16`, `title15` | 18–15px | Bold |
| `body16`, `body14`, `body13` | 16–13px | Regular |
| `body14Medium`, `body13Bold` | 14–13px | Medium/Bold |
| `caption12`, `caption12Med` | 12px | Regular/Medium |
| `overline10` | 10px | Medium |
| `nav10`, `nav10Bold` | 10px | Regular/Bold |

### Durations (`FormaDurations`)

| Token | Value | Usage |
|-------|-------|-------|
| `fade` | 220ms | Quick transitions |
| `smart` | 280ms | Standard animations |
| `slow` | 400ms | Page transitions |

## Theming

### FormaThemeExtension

Components read colors from this extension. Theme packages fill in the 26 semantic color slots:

```dart
FormaThemeExtension(
  appBackground: ...,
  cardBackground: ...,
  primaryColor: ...,
  primarySurface: ...,
  primaryBorder: ...,
  secondaryColor: ...,
  secondarySurface: ...,
  accentColor: ...,
  accentSurface: ...,
  textPrimary: ...,
  textMuted: ...,
  textHint: ...,
  border: ...,
  borderStrong: ...,
  successColor: ...,
  successSurface: ...,
  successText: ...,
  warningColor: ...,
  warningSurface: ...,
  warningText: ...,
  urgencySurface: ...,
  errorColor: ...,
  errorSurface: ...,
  errorText: ...,
  infoSurface: ...,
  infoText: ...,
)
```

### FormaTheme.build

Generates a complete `ThemeData` from a `FormaThemeExtension`:

```dart
final theme = FormaTheme.build(
  extension: myExtension,
  fontFamily: 'Inter',
  seedColor: myPrimaryColor,
);
```

## License

MIT
