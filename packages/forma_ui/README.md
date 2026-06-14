# forma_ui

Brand-agnostic UI primitives of the [Forma Design System](https://github.com/RodolfoBonis/forma).

Buttons, inputs, cards, navigation, feedback and overlay components that consume tokens and the
theme contract from `forma_foundation` and icons from `forma_icons`. Components carry no brand
colors and no domain logic — colors come from `FormaThemeExtension`, text from
`FormaTypographyExtension`, so the same component follows any brand theme.

`forma_ui` re-exports `forma_foundation`, so a single import brings the primitives and the tokens.

```dart
import 'package:forma_ui/forma_ui.dart';

FormaButton.primary(label: 'Confirmar', onPressed: () {});
const FormaBadge(label: 'Ativo', variant: FormaBadgeVariant.primary);
FormaTextField(label: 'Nome', hint: 'Digite seu nome');
```

See the [repository README](https://github.com/RodolfoBonis/forma) for the full component list and
architecture.
