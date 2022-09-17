import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pb_app/utils.dart';

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

  // Title field
  final _textEditingController = TextEditingController();

  // Home screen and lock screen page view controller
  final _pageController = PageController(
    viewportFraction: 0.9,
  );

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _textEditingController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black12,
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: platformAwareBorderRadius(10),
                        color: Colors.black12,
                      ),
                      child: AnimatedBuilder(
                        animation: Listenable.merge([
                          _nameFocusNode,
                          _textEditingController,
                        ]),
                        builder: (context, child) => Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _textEditingController,
                                autofocus: true,
                                focusNode: _nameFocusNode,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                                cursorColor: Colors.black87,
                                textCapitalization:
                                    TextCapitalization.characters,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      _nameFocusNode.hasFocus ? '' : 'Name',
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _textEditingController.clear(),
                              child: AnimatedOpacity(
                                opacity:
                                    _textEditingController.text.isEmpty ? 0 : 1,
                                duration: const Duration(milliseconds: 300),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Icon(
                                    Icons.clear_all_rounded,
                                    color: Colors.red.shade300,
                                    size: 36,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: 2,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => index == 0
              ? const _Card('Home Screen')
              : const _Card('Lock Screen'),
        ),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: SmoothRectangleBorder(
                borderRadius: platformAwareBorderRadius(10),
              ),
            ),
            child: const Text('Continue to Details'),
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 5,
      ),
      color: Colors.black38,
      shape: platformAwareShape(50),
      child: InkWell(
        onTap: () {
          // TODO: InkWell not working properly into stack (https://github.com/flutter/flutter/issues/104519)
          // debugPrint('I have been clicked even if the ripple isn\'t showing');
        },
        splashColor: Colors.black12,
        highlightColor: Colors.black12,
        customBorder: platformAwareShape(50),
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0, 0.7),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: platformAwareBorderRadius(99),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              child: Container(
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
