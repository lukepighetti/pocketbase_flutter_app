import 'package:flutter/material.dart';
import 'package:pb_app/submission/widgets/card.dart';
import 'package:pb_app/submission/widgets/top_bar.dart';

class SubmissionFirstPage extends StatelessWidget {
  const SubmissionFirstPage({
    Key? key,
    required FocusNode nameFocusNode,
    required TextEditingController titleController,
    required PageController uploadPageController,
    required List<SubmissionCard> listCards,
  })  : _nameFocusNode = nameFocusNode,
        _titleController = titleController,
        _uploadPageController = uploadPageController,
        _listCards = listCards,
        super(key: key);

  final FocusNode _nameFocusNode;
  final TextEditingController _titleController;
  final PageController _uploadPageController;
  final List<SubmissionCard> _listCards;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: kToolbarHeight,
          child: SubmissionTopBar(
            nameFocusNode: _nameFocusNode,
            titleController: _titleController,
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: _uploadPageController,
            itemCount: 2,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => _listCards[index],
          ),
        ),
      ],
    );
  }
}
