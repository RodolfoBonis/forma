# forma_icons

Icon layer of the [Forma Design System](https://github.com/RodolfoBonis/forma).

Reference icons by semantic intent so a brand can swap any icon for its own SVG without
touching component code:

- **`FormaIconKey`** — semantic keys (e.g. `confirm`, `close`, `home`) backed by Material defaults.
- **`FormaIconRegistry` / `FormaIconScope`** — let a brand override any key with an `SvgFormaIcon`.
- **`FormaIcon`** — renders Material glyphs and brand SVGs uniformly, with theme color resolution.

```dart
import 'package:forma_icons/forma_icons.dart';

// Material default:
const FormaIcon(FormaIconKey.confirm);

// Brand SVG override for a subtree:
FormaIconScope(
  registry: const FormaIconRegistry.withOverrides({
    FormaIconKey.confirm: SvgFormaIcon('assets/icons/confirm.svg'),
  }),
  child: const FormaIcon(FormaIconKey.confirm),
);
```

See the [repository README](https://github.com/RodolfoBonis/forma) for the full architecture.
