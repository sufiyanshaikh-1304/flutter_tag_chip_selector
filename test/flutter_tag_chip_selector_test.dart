import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tag_chip_selector/flutter_tag_chip_selector.dart';

void main() {
  group('TagChipSelector', () {
    final tags = const [
      TagItem(label: 'Flutter'),
      TagItem(label: 'Dart'),
      TagItem(label: 'Firebase'),
    ];

    testWidgets(
      'displays all tags',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TagChipSelector(
                tags: tags,
              ),
            ),
          ),
        );

        expect(find.text('Flutter'), findsOneWidget);
        expect(find.text('Dart'), findsOneWidget);
        expect(find.text('Firebase'), findsOneWidget);
      },
    );

    testWidgets(
      'selects a tag',
          (tester) async {
        List<String> selected = [];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TagChipSelector(
                tags: tags,
                onSelectionChanged: (value) {
                  selected = value;
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Flutter'));
        await tester.pumpAndSettle();

        expect(selected, contains('Flutter'));
      },
    );

    testWidgets(
      'removes a selected tag',
          (tester) async {
        List<String> selected = ['Flutter'];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TagChipSelector(
                tags: tags,
                selectedTags: selected,
                onSelectionChanged: (value) {
                  selected = value;
                },
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final closeIcon = find.byIcon(Icons.close_rounded);

        expect(closeIcon, findsOneWidget);

        await tester.tap(closeIcon);
        await tester.pumpAndSettle();

        expect(selected, isNot(contains('Flutter')));
      },
    );

    testWidgets(
      'supports multiple selected tags',
          (tester) async {
        List<String> selected = [];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TagChipSelector(
                tags: tags,
                onSelectionChanged: (value) {
                  selected = value;
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Flutter'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Dart'));
        await tester.pumpAndSettle();

        expect(selected.length, 2);
        expect(selected, contains('Flutter'));
        expect(selected, contains('Dart'));
      },
    );
  });
}