import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pb_app/models/submission_form_state.dart';
import 'package:provider/provider.dart';

class EyeDropper extends StatelessWidget {
  const EyeDropper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.colorize),
      onPressed: () {
        showDialog(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: SlidePicker(
                pickerColor: context
                    .read<SubmissionFormState>()
                    .selectedBackgroundColor ??
                    Colors.white,
                onColorChanged: (color) => context
                    .read<SubmissionFormState>()
                    .setSelectedBackgroundColor(color),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Got it'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}