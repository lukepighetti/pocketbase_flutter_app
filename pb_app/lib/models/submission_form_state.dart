import 'dart:io';

import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import 'package:palette_generator/palette_generator.dart';

class SubmissionFormState extends ChangeNotifier {
  Color? _card1Dominant;
  Color _selectedBackgroundColor = Colors.white;

  Color get selectedBackgroundColor => _selectedBackgroundColor;

  SubmissionFormState();

  void setCard1Image(File? image) async {
    if (image != null) {
      final palette = await PaletteGenerator.fromImageProvider(FileImage(image));
      _card1Dominant = palette.dominantColor?.color;
      setSelectedBackgroundColor(_card1Dominant);
    }
  }

  void setSelectedBackgroundColor(Color? color) {
    _selectedBackgroundColor = color ?? Colors.white;
    notifyListeners();
  }
}