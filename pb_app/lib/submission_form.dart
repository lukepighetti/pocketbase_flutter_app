import 'dart:io';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pb_app/modals.dart';
import 'package:pb_app/models/submission_form_state.dart';
import 'package:pb_app/submission_fom/EyeDropper.dart';
import 'package:pb_app/utils.dart';
import 'package:provider/provider.dart';

// TODO: get this value from the actual device specifications
const _kPhotoAspectRatio = 9 / 19.5;

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

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: ChangeNotifierProvider<SubmissionFormState>(
        create: (_) => SubmissionFormState(),
        child: UploadPageScaffold(
        ),
      ),
    );
  }
}

class UploadPageScaffold extends StatefulWidget {
  const UploadPageScaffold({super.key});

  @override
  State<UploadPageScaffold> createState() => _UploadPageScaffoldState();
}

class _UploadPageScaffoldState extends State<UploadPageScaffold> {
  PageController? _pageController;

  @override
  Widget build(BuildContext context) {
    return Consumer<SubmissionFormState>(
      builder: (context, value, child) {
        assert(child != null, 'oh fuck put it back in!');
        return Theme(
          data: Theme.of(context)
              .copyWith(scaffoldBackgroundColor: value.selectedBackgroundColor),
          child: child!,
        );
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            minimum: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
                const Spacer(),
                const EyeDropper(),
              ],
            ),
          ),
        ),
        body: LayoutBuilder(builder: (context, details) {
          // Calculate the PageView viewportFraction for a target
          // card aspect ratio
          const gapWidth = 20.0;

          final targetWidth = details.biggest.height * _kPhotoAspectRatio;
          final actualWidth = details.biggest.width;

          return PageView(
            controller: _pageController ??= PageController(
              viewportFraction: (targetWidth + gapWidth) / actualWidth,
            ),
            clipBehavior: Clip.none,
            children: const [
              _Card('Home Screen'),
              _Card('Lock Screen'),
            ],
          );
        }),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: ElevatedButton(
            onPressed: () => ToastProvider.of(context).showFpoWarning(),
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

class _Card extends StatefulWidget {
  const _Card(this.title);

  final String title;

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: _kPhotoAspectRatio,
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 10,
          color: Colors.grey.shade600,
          shape: platformAwareShape(50),
          child: InkWell(
            onTap: () async {
              try {
                final xfile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (xfile == null || !mounted) return;
                setState(() {
                  image = File(xfile.path);
                });
                context.read<SubmissionFormState>().setCard1Image(image!);
              } catch (e) {
                if (kDebugMode && mounted) {
                  ToastProvider.of(context).showToast(e.toString());
                }
              }
            },
            splashColor: Colors.black12,
            highlightColor: Colors.black12,
            customBorder: platformAwareShape(50),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(SmoothRadius(
                      cornerRadius: 50,
                      cornerSmoothing: Platform.isIOS ? 0.6 : 0.2,
                    )),
                    image: image != null
                        ? DecorationImage(
                            image: FileImage(image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
                Center(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.70),
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
                Align(
                  alignment: const Alignment(0, 0.7),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: platformAwareBorderRadius(99),
                    ),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
