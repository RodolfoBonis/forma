# forma_theme_spooliq

SpoolIQ brand theme for the [Forma Design System](https://github.com/RodolfoBonis/forma).

Light and dark themes (coral primary with teal accent) tuned for desktop: they fill
`FormaThemeExtension`, set the compact `FormaShapeExtension.desktop` density and use Inter.
Depends only on `forma_foundation`.

```dart
import 'package:forma_theme_spooliq/forma_theme_spooliq.dart';

MaterialApp(
  theme: SpooliqTheme.light,
  darkTheme: SpooliqTheme.dark,
  home: const HomePage(),
);
```

Use it with the `forma_ui` primitives, which read their colors, typography and shape from the
active theme. See the [repository README](https://github.com/RodolfoBonis/forma) for the full
architecture.
