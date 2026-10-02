import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';

void main() {
  testWidgets(
    'Tag Chip Selector example app loads',
        (tester) async {
      await tester.pumpWidget(
        const TagChipSelectorExampleApp(),
      );

      expect(find.text('Tag Chip Selector'), findsOneWidget);
      expect(find.text('Select your skills'), findsOneWidget);
    },
  );
}