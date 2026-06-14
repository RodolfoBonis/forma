# Forma — Domain Widget Handoff

These widgets were **app-specific** and have been removed from the shared Forma
packages. Forma is now a brand-agnostic base (`forma_foundation`, `forma_icons`,
`forma_ui`, theme packages); domain widgets belong in each app's own repository,
composed on top of `forma_ui`.

Copy the relevant files from `handoff/widgets/` into the owning app and add the
dependencies listed below. This folder is **not** part of the melos workspace
and is **not** published.

## How to adopt

1. Move the file(s) into your app (e.g. `lib/ui/widgets/`).
2. Ensure the app depends on the packages each widget imports:
   ```yaml
   dependencies:
     forma_foundation: ^1.2.0
     forma_ui: ^1.2.0          # only if the widget imports it
     forma_icons: ^1.2.0       # only if you migrate icons to FormaIcon
   ```
   `forma_ui` re-exports `forma_foundation`, so importing `forma_ui` alone is
   enough for widgets that use both.
3. Replace any hard-coded brand color with a `FormaThemeExtension` slot (or a
   color owned by the app), so the widget follows the active theme.

## Widgets

| File | What it is | Candidate owner | Imports | Brand-color notes |
|------|------------|-----------------|---------|-------------------|
| `forma_order_card.dart` | Task/order card (status, title, tags, action slots) | Plantão Fácil | `forma_foundation` | None — colors already from `FormaThemeExtension`. |
| `forma_person_chip.dart` | Avatar initial + name chip | Plantão Fácil | `forma_ui` (uses `FormaAvatar`) | None. |
| `forma_proof_icon.dart` | Proof-state icon (`FormaProofType`) | Plantão Fácil | `forma_foundation` | Uses Material icons; consider migrating to `FormaIcon`. |
| `forma_role_badge.dart` | Dom/Sub role badge (`color` param) | Dominus | `forma_foundation` | Color is passed in by the caller. |
| `forma_urgency_header.dart` | Urgency banner | Plantão Fácil | `forma_foundation` | Uses `ext.urgencySurface`. |
| `forma_whatsapp_preview.dart` | WhatsApp message preview | Plantão Fácil | `forma_foundation` | Hard-codes WhatsApp greens (`0xFF25D366`, `0xFF128C7E`, `0xFFDCF8C6`) — brand-correct for WhatsApp; keep as constants in the app. |

> Ownership above is a recommendation. Confirm with product which app owns each
> widget (some may be shared via an app-level shared package).

## Carved-out brand button/badge variants

`FormaButton` and `FormaBadge` in `forma_ui` no longer ship app-specific
variants. Rebuild them in the app as thin wrappers over the generic primitives.

### WhatsApp / Safeword buttons

`FormaButton` keeps only semantic variants (`primary`, `secondary`, `danger`,
`ghost`, `disabled`). Reconstruct brand CTAs with the default constructor and
brand colors owned by the app:

```dart
// app/lib/ui/whatsapp_button.dart
const _whatsAppGreen = Color(0xFF25D366);

class WhatsAppButton extends StatelessWidget {
  const WhatsAppButton({required this.label, this.onPressed, super.key});
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    // Option A: theme it via a FormaThemeExtension slot.
    // Option B: a dedicated branded button (shown here).
    return Theme(
      data: Theme.of(context).copyWith(
        extension: /* a FormaThemeExtension with primaryColor: _whatsAppGreen */,
      ),
      child: FormaButton.primary(label: label, onPressed: onPressed),
    );
  }
}
```

For **safeword** (loud red stop action), do the same with `0xFFFF3B30`, or add a
dedicated semantic slot to your theme.

### Domain badges (confirmada / pendente / aoVivo …)

`FormaBadge` now exposes generic semantic variants:
`success`, `warning`, `error`, `info`, `neutral`, `primary`. Map the app's
domain status to a variant (and supply the label):

```dart
// app/lib/ui/status_badge.dart
FormaBadge mapStatus(OrderStatus s) => switch (s) {
  OrderStatus.confirmada => const FormaBadge(label: 'Confirmada', variant: FormaBadgeVariant.success),
  OrderStatus.pendente   => const FormaBadge(label: 'Pendente',   variant: FormaBadgeVariant.warning),
  OrderStatus.cancelada  => const FormaBadge(label: 'Cancelada',  variant: FormaBadgeVariant.error),
  OrderStatus.oficial    => const FormaBadge(label: 'Oficial',    variant: FormaBadgeVariant.info),
  OrderStatus.ativo      => const FormaBadge(label: 'Ativo',      variant: FormaBadgeVariant.primary),
};
```

The previous `aoVivo` badge used a hard-coded color (`0xFF1A1840` /
`0xFFB5ABFF`). Recreate it as an app widget if still needed, or add the colors
to the app's theme.
