import 'dart:io';

import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import 'package:palette_generator/palette_generator.dart';

class SubmissionFormState extends ChangeNotifier {
  Color? _card1Dominant;
  Color _selectedBackgroundColor = Colors.white;

  Color get selectedBackgroundColor => _selectedBackgroundColor;

  bool get isLightBackground =>
      _selectedBackgroundColor.computeLuminance() > 0.5;

  SubmissionFormState();

  void setCard1Image(File image) async {
    final palette = await PaletteGenerator.fromImageProvider(FileImage(image));
    _card1Dominant = palette.dominantColor?.color;
    final Color pastelTone;
    if (_card1Dominant == null) {
      pastelTone = Colors.white;
    } else {
      final desaturatedValue =
          HSLColor.fromColor(_card1Dominant!).withSaturation(.6).toColor();
      pastelTone = Color.lerp(Colors.white, desaturatedValue, .9)!;
    }
    setSelectedBackgroundColor(pastelTone);
  }

  void setSelectedBackgroundColor(Color? color) {
    _selectedBackgroundColor = color ?? Colors.white;
    notifyListeners();
  }
}
