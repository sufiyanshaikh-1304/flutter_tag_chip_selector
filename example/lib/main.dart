import 'package:flutter/material.dart';
import 'package:flutter_tag_chip_selector/flutter_tag_chip_selector.dart';

void main() {
  runApp(const TagChipSelectorExampleApp());
}

class TagChipSelectorExampleApp extends StatelessWidget {
  const TagChipSelectorExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tag Chip Selector',

      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const TagChipSelectorDemo(),
    );
  }
}

class TagChipSelectorDemo extends StatefulWidget {
  const TagChipSelectorDemo({super.key});

  @override
  State<TagChipSelectorDemo> createState() =>
      _TagChipSelectorDemoState();
}

class _TagChipSelectorDemoState
    extends State<TagChipSelectorDemo> {
  List<String> selectedTags = [];

  final List<TagItem> tags = const [
    TagItem(label: 'Flutter'),
    TagItem(label: 'Dart'),
    TagItem(label: 'Firebase'),
    TagItem(label: 'Android'),
    TagItem(label: 'iOS'),
    TagItem(label: 'UI/UX'),
    TagItem(label: 'REST API'),
    TagItem(label: 'GitHub'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tag Chip Selector',

          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select your skills',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Choose multiple tags and remove them anytime.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),

            TagChipSelector(
              tags: tags,
              selectedTags: selectedTags,
              removable: true,
              dynamicColors: true,
              onSelectionChanged: (values) {
                setState(() {
                  selectedTags = values;
                });
              },
            ),

            const SizedBox(height: 32),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.blue.shade100,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selected Tags',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    selectedTags.isEmpty
                        ? 'No tags selected'
                        : selectedTags.join(', '),
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}