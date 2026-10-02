import 'package:flutter/material.dart';

class ChipColors {
  const ChipColors._();

  static const List<Color> palette = [
    Color(0xFF2563EB),
    Color(0xFF16A34A),
    Color(0xFFF59E0B),
    Color(0xFF9333EA),
    Color(0xFFDC2626),
    Color(0xFF0891B2),
    Color(0xFF4F46E5),
    Color(0xFFDB2777),
  ];

  static Color get(int index) {
    return palette[index % palette.length];
  }
}