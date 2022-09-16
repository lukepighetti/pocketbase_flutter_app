import 'package:flutter/material.dart';
import 'package:pb_app/submission/theme/theme.dart';

class SubmissionTopBar extends StatelessWidget {
  const SubmissionTopBar({
    Key? key,
    required FocusNode nameFocusNode,
    required TextEditingController titleController,
  })  : _nameFocusNode = nameFocusNode,
        _titleController = titleController,
        super(key: key);

  final FocusNode _nameFocusNode;
  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: SubmissionTheme.gap,
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).maybePop(),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: SubmissionTheme.quitColor,
            ),
            child: const Icon(
              Icons.close_rounded,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          width: SubmissionTheme.gap,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(64),
              color: SubmissionTheme.primaryColor,
            ),
            child: Row(
              children: [
                Expanded(
                  child: AnimatedBuilder(
                    animation: _nameFocusNode,
                    builder: (context, _) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          textSelectionTheme: TextSelectionThemeData(
                            selectionHandleColor:
                                SubmissionTheme.secondaryColor,
                            selectionColor: SubmissionTheme.secondaryColor,
                          ),
                        ),
                        child: TextField(
                          controller: _titleController,
                          autofocus: true,
                          textAlign: TextAlign.center,
                          focusNode: _nameFocusNode,
                          cursorColor: SubmissionTheme.cursorColor,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusColor: SubmissionTheme.cursorColor,
                            hintText: _nameFocusNode.hasFocus ? '' : 'Name',
                          ),
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () => _titleController.clear(),
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: SubmissionTheme.secondaryColor,
                    ),
                    child: const Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: SubmissionTheme.gap,
        ),
      ],
    );
  }
}
