import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pb_app/utils.dart';
import 'package:pb_app/workflows.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';

class LoginModal extends StatefulWidget {
  const LoginModal._();

  static Future<void> show(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return const LoginModal._();
      },
    );
  }

  @override
  State<LoginModal> createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool get hasEmailAndPassword =>
      emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

  // TODO: should this be a workflow?
  Future<void> submitEmailAndPassword() async {
    // TODO: show global loading indicator
    debugPrint('submit!');

    try {
      await client.users
          .authViaEmail(emailController.text, passwordController.text);
      // TODO: use success toast to say we succeeded
    } on ClientException catch (e) {
      // TODO: use error toast
      ToastProvider.of(context).showToast(e.message);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: wrap in AutofillGroup
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(25),
      children: [
        TextField(
          controller: emailController,
          autocorrect: false,
          autofocus: true,
          autofillHints: const [AutofillHints.email],
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            label: Text('Email'),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passwordController,
          autocorrect: false,
          obscureText: true,
          autofillHints: const [AutofillHints.password],
          textInputAction: TextInputAction.done,
          onSubmitted: (_) {
            if (hasEmailAndPassword) {
              submitEmailAndPassword();
            }
          },
          decoration: const InputDecoration(
            label: Text('Password'),
          ),
        ),
        const SizedBox(height: 25),
        AnimatedBuilder(
          animation: Listenable.merge([
            emailController,
            passwordController,
          ]),
          builder: (context, _) {
            return ElevatedButton(
              onPressed: hasEmailAndPassword
                  ? () {
                      submitEmailAndPassword();
                    }
                  : null,
              child: const Text('Login to Continue'),
            );
          },
        ),
        // TODO: add button to create account
        // TextButton(child: Text('Create account'), onPressed: () {})
      ],
    );
  }
}

// TODO: should this be migrated to InheritedWidget?
class ToastProvider extends StatefulWidget {
  const ToastProvider({super.key, required this.child});

  final Widget child;

  static ToastProviderState of(BuildContext context) =>
      Provider.of<ToastProviderState>(context, listen: false);

  @override
  State<ToastProvider> createState() => ToastProviderState();
}

class ToastProviderState extends State<ToastProvider> {
  var _isLoadingVisible = false;
  Timer? _loadingTimeoutTimer;

  void showLoadingIndicator() {
    setState(() {
      _isLoadingVisible = true;
    });

    _loadingTimeoutTimer?.cancel();
    _loadingTimeoutTimer = Timer(const Duration(seconds: 10), () {
      hideLoadingIndicator();
    });
  }

  void hideLoadingIndicator() {
    setState(() {
      _isLoadingVisible = false;
    });
  }

  var _toastVisible = false;
  var _toastText = '';

  Timer? _toastTimeoutTimer;

  void showToast(String text) {
    setState(() {
      _toastText = text;
      _toastVisible = true;
    });

    _toastTimeoutTimer?.cancel();
    _toastTimeoutTimer = Timer(const Duration(seconds: 5), () {
      hideToast();
    });
  }

  void hideToast() {
    setState(() {
      _toastVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 500);
    const curve = Curves.easeInOut;

    return Provider.value(
      value: this,
      child: Stack(
        fit: StackFit.expand,
        children: [
          widget.child,
          IgnorePointer(
            ignoring: !_isLoadingVisible,
            child: AnimatedOpacity(
              opacity: _isLoadingVisible ? 1 : 0,
              duration: duration,
              curve: curve,
              child: const ColoredBox(color: Colors.black54),
            ),
          ),
          IgnorePointer(
            ignoring: !_isLoadingVisible,
            child: Center(
              child: AnimatedOpacity(
                opacity: _isLoadingVisible ? 1 : 0,
                duration: duration,
                curve: curve,
                child: const SizedBox.square(
                  dimension: 100,
                  child: Card(
                    elevation: 10,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.80),
            child: AnimatedOpacity(
              opacity: _toastVisible ? 1 : 0,
              duration: duration,
              curve: curve,
              child: Card(
                color: Colors.red,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _toastText,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
