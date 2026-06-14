# forma_foundation

Foundation layer of the [Forma Design System](https://github.com/RodolfoBonis/forma).

Provides the brand-agnostic base every Forma package builds on:

- **Design tokens** — `FormaSpacing`, `FormaRadius`, `FormaDurations`, `FormaTypography`.
- **Theme engine** — `FormaTheme.build` produces a Material 3 `ThemeData` and registers
  the Forma extensions.
- **Contracts** — `FormaThemeExtension` (semantic color slots) and
  `FormaTypographyExtension` (a font-driven type scale, so each brand can ship its own typeface).

It contains no components and no brand colors. Theme packages fill the contracts; `forma_ui`
consumes them.

```dart
import 'package:forma_foundation/forma_foundation.dart';

final theme = FormaTheme.build(
  extension: myBrandExtension,
  fontFamily: 'Inter',
  seedColor: const Color(0xFF9B2242),
);
```

See the [repository README](https://github.com/RodolfoBonis/forma) for the full architecture.
