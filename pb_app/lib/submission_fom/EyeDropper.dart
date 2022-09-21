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
    final submissionFormState = context.read<SubmissionFormState>();
    return IconButton(
      icon: const Icon(Icons.colorize),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) {
            return Theme(
              data: _adaptThemeBrightness(
                Theme.of(context),
                submissionFormState,
              ),
              child: _DialogWidget(submissionFormState: submissionFormState),
            );
          },
        );
      },
    );
  }

  ThemeData _adaptThemeBrightness(
      ThemeData theme, SubmissionFormState submissionFormState) {
    final foregroundColor =
        submissionFormState.isLightBackground ? Colors.black : Colors.white;
    return theme.copyWith(
        textTheme: theme.textTheme.copyWith(
      bodyText2: theme.textTheme.bodyText2!.copyWith(
        color: foregroundColor,
      ),
      bodyText1: theme.textTheme.bodyText1!.copyWith(
        color: foregroundColor,
      ),
      headline6: theme.textTheme.headline6!.copyWith(
        color: foregroundColor,
      ),
    ));
  }
}

class _DialogWidget extends StatelessWidget {
  const _DialogWidget({
    Key? key,
    required this.submissionFormState,
  }) : super(key: key);

  final SubmissionFormState submissionFormState;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set background'),
      backgroundColor: submissionFormState.isLightBackground
          ? Colors.white
          : Colors.grey.shade900,
      content: SingleChildScrollView(
        child: SlidePicker(
          enableAlpha: false,
          pickerColor: submissionFormState.selectedBackgroundColor,
          onColorChanged: submissionFormState.setSelectedBackgroundColor,
        ),
      ),
      actions: [
        ElevatedButton(
          child: const Text('Done'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
