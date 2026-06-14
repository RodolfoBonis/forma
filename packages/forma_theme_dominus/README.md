# forma_theme_dominus

Dominus brand theme for the [Forma Design System](https://github.com/RodolfoBonis/forma).

A dark theme (wine-red primary with brass accent) that fills `FormaThemeExtension` and supplies a
font family. Depends only on `forma_foundation`.

```dart
import 'package:forma_theme_dominus/forma_theme_dominus.dart';

MaterialApp(theme: DominusTheme.dark, home: const HomePage());
```

Use it with the `forma_ui` primitives, which read their colors and typography from the active
theme. See the [repository README](https://github.com/RodolfoBonis/forma) for the full architecture.
