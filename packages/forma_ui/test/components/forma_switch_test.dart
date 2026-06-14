import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

void main() {
  group('FormaSwitch', () {
    testWidgets('toggles value on tap', (tester) async {
      bool? newValue;
      await tester.pumpWidget(
        wrapForTest(FormaSwitch(value: false, onChanged: (v) => newValue = v)),
      );

      await tester.tap(find.byType(FormaSwitch));
      expect(newValue, isTrue);
    });

    testWidgets('does not call onChanged when disabled', (tester) async {
      var called = false;
      await tester.pumpWidget(
        wrapForTest(const FormaSwitch(value: false, onChanged: null)),
      );

      await tester.tap(find.byType(FormaSwitch));
      expect(called, isFalse);
    });
  });
}
