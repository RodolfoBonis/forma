import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

void main() {
  // Use a wide surface so the three-pane (non-drawer) layout is exercised.
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Future<void> pumpGallery(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1600, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      GalleryApp(
        root: [
          GalleryFolder('Components', children: [_buttonComponent()]),
        ],
        themes: [GalleryTheme('Test', PlantaoFacilTestTheme.theme)],
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('navigates to a use case and renders the preview', (
    tester,
  ) async {
    await pumpGallery(tester);

    // Expand the Buttons folder, then the FormaButton component.
    await tester.tap(find.text('Buttons'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('FormaButton'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Playground'));
    await tester.pumpAndSettle();

    // The preview shows the button with its initial knob value.
    expect(find.widgetWithText(FormaButton, 'Confirmar'), findsOneWidget);
  });

  testWidgets('editing a knob updates the preview live', (tester) async {
    await pumpGallery(tester);

    await tester.tap(find.text('Buttons'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('FormaButton'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Playground'));
    await tester.pumpAndSettle();

    // The controls panel registered a "Label" text field; edit it.
    final labelField = find.widgetWithText(TextField, 'Confirmar');
    expect(labelField, findsOneWidget);

    await tester.enterText(labelField, 'Salvar');
    await tester.pumpAndSettle();

    // Preview reflects the new value; old value is gone.
    expect(find.widgetWithText(FormaButton, 'Salvar'), findsOneWidget);
    expect(find.widgetWithText(FormaButton, 'Confirmar'), findsNothing);
  });
}

GalleryComponent _buttonComponent() {
  return GalleryComponent(
    'FormaButton',
    useCases: [
      UseCase('Playground', (context, k) {
        final label = k.string(label: 'Label', initialValue: 'Confirmar');
        return Padding(
          padding: const EdgeInsets.all(24),
          child: FormaButton(label: label, onPressed: () {}),
        );
      }),
      UseCase('All Variants', (context, k) => const SizedBox.shrink()),
    ],
  );
}

/// Minimal theme carrying a [FormaThemeExtension] so Forma components render.
abstract final class PlantaoFacilTestTheme {
  static final ThemeData theme = ThemeData.light().copyWith(
    extensions: const [
      FormaThemeExtension(
        appBackground: Color(0xFFFFFFFF),
        cardBackground: Color(0xFFF5F5F5),
        primaryColor: Color(0xFF2E7D32),
        primarySurface: Color(0xFFE8F5E9),
        primaryBorder: Color(0xFFA5D6A7),
        secondaryColor: Color(0xFF3949AB),
        secondarySurface: Color(0xFFE8EAF6),
        accentColor: Color(0xFFC9683B),
        accentSurface: Color(0xFFFBE9E7),
        textPrimary: Color(0xFF1A1A1A),
        textMuted: Color(0xFF5A5A5A),
        textHint: Color(0xFF9E9E9E),
        border: Color(0xFFE0E0E0),
        borderStrong: Color(0xFFBDBDBD),
        successColor: Color(0xFF2E7D32),
        successSurface: Color(0xFFE8F5E9),
        successText: Color(0xFF1B5E20),
        warningColor: Color(0xFFF9A825),
        warningSurface: Color(0xFFFFF8E1),
        warningText: Color(0xFF795548),
        urgencySurface: Color(0xFFFFEBEE),
        errorColor: Color(0xFFC62828),
        errorSurface: Color(0xFFFFEBEE),
        errorText: Color(0xFFB71C1C),
        infoSurface: Color(0xFFE3F2FD),
        infoText: Color(0xFF1565C0),
      ),
    ],
  );
}
