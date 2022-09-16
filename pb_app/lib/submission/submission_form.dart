import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pb_app/submission/pages/first_page.dart';
import 'package:pb_app/submission/widgets/card.dart';

class SubmissionFormScreen extends StatefulWidget {
  const SubmissionFormScreen._();

  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return const SubmissionFormScreen._();
        },
      ),
    );
  }

  @override
  State<SubmissionFormScreen> createState() => _SubmissionFormScreenState();
}

class _SubmissionFormScreenState extends State<SubmissionFormScreen> {
  // used to hide the centered hint when focused
  final _nameFocusNode = FocusNode();

  final _titleController = TextEditingController();
  final _uploadPageController = PageController(
    viewportFraction: .9,
  );
  final _submissionController = PageController();

  // TODO: complete second page
  late final _pages = [
    SubmissionFirstPage(
      nameFocusNode: _nameFocusNode,
      titleController: _titleController,
      uploadPageController: _uploadPageController,
      listCards: _listCards,
    ),
    Container(),
  ];

  final _listCards = [
    SubmissionCard(
      iconData: Icons.file_open_rounded,
      title: 'Homescreen',
      subtitle: 'Upload the file of your homescreen',
      onTap: () => debugPrint('Homescreen upload'),
    ),
    SubmissionCard(
      iconData: Icons.file_open_rounded,
      title: 'Lockscreen',
      subtitle: 'Upload the file of your lockscreen',
      onTap: () => debugPrint('Lockscreen upload'),
    ),
  ];

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _titleController.dispose();
    _uploadPageController.dispose();
    _submissionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _submissionController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => _pages[index],
                ),
              ),
              GestureDetector(
                onTap: () => _submissionController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next'.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
