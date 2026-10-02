import 'package:flutter/material.dart';

import '../models/tag_item.dart';
import '../utils/chip_colors.dart';

class TagChipSelector extends StatefulWidget {
  final List<TagItem> tags;
  final List<String> selectedTags;
  final ValueChanged<List<String>>? onSelectionChanged;

  final bool removable;
  final bool dynamicColors;

  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;

  final double spacing;
  final double runSpacing;
  final double borderRadius;

  const TagChipSelector({
    super.key,
    required this.tags,
    this.selectedTags = const [],
    this.onSelectionChanged,
    this.removable = true,
    this.dynamicColors = true,
    this.selectedColor,
    this.unselectedColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.spacing = 8,
    this.runSpacing = 10,
    this.borderRadius = 20,
  });

  @override
  State<TagChipSelector> createState() => _TagChipSelectorState();
}

class _TagChipSelectorState extends State<TagChipSelector> {
  late List<String> _selectedTags;

  @override
  void initState() {
    super.initState();
    _selectedTags = List<String>.from(widget.selectedTags);
  }

  @override
  void didUpdateWidget(covariant TagChipSelector oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedTags != widget.selectedTags) {
      _selectedTags = List<String>.from(widget.selectedTags);
    }
  }

  void _toggleTag(TagItem tag) {
    final updatedTags = List<String>.from(_selectedTags);

    if (updatedTags.contains(tag.label)) {
      updatedTags.remove(tag.label);
    } else {
      updatedTags.add(tag.label);
    }

    _updateSelection(updatedTags);
  }

  void _removeTag(String label) {
    final updatedTags = List<String>.from(_selectedTags)
      ..remove(label);

    _updateSelection(updatedTags);
  }

  void _updateSelection(List<String> tags) {
    setState(() {
      _selectedTags = tags;
    });

    widget.onSelectionChanged?.call(
      List<String>.unmodifiable(_selectedTags),
    );
  }

  Color _getSelectedColor(int index, TagItem tag) {
    if (tag.color != null) {
      return tag.color!;
    }

    if (widget.selectedColor != null) {
      return widget.selectedColor!;
    }

    if (widget.dynamicColors) {
      return ChipColors.get(index);
    }

    return Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
      children: List.generate(widget.tags.length, (index) {
        final tag = widget.tags[index];
        final isSelected = _selectedTags.contains(tag.label);

        final selectedColor = _getSelectedColor(index, tag);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          child: FilterChip(
            label: Text(tag.label),
            selected: isSelected,
            onSelected: (_) => _toggleTag(tag),
            showCheckmark: false,
            avatar: isSelected
                ? const Icon(
              Icons.check_rounded,
              size: 18,
            )
                : null,
            backgroundColor:
            widget.unselectedColor ??
                Theme.of(context).colorScheme.surfaceContainerHighest,
            selectedColor: selectedColor,
            side: BorderSide(
              color: isSelected
                  ? selectedColor
                  : Theme.of(context).colorScheme.outlineVariant,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                widget.borderRadius,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? widget.selectedTextColor ?? Colors.white
                  : widget.unselectedTextColor ??
                  Theme.of(context).colorScheme.onSurface,
            ),
            deleteIcon: isSelected && widget.removable
                ? Icon(
              Icons.close_rounded,
              size: 17,
              color: widget.selectedTextColor ??
                  Colors.white,
            )
                : null,
            onDeleted: isSelected && widget.removable
                ? () => _removeTag(tag.label)
                : null,
          ),
        );
      }),
    );
  }
}