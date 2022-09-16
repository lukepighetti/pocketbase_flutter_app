import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _nameFocusNode,
                    builder: (context, _) {
                      return TextField(
                        autofocus: true,
                        focusNode: _nameFocusNode,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: _nameFocusNode.hasFocus ? '' : 'Name',
                        ),
                      );
                    },
                  ),
                ),

                /// Dummy IconButton to center the text field
                ///
                /// Learn the rules like a scientist
                /// so you can break them like an artist.
                const Visibility(
                  visible: false,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 550,
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
              ),
              MaterialButton(
                onPressed: () {
                  print('hi');
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                minWidth: 100,
                height: 100,
                child: const Icon(Icons.add, size: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
