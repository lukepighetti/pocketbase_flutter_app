import 'package:flutter/widgets.dart';
import 'package:pb_app/config.dart';
import 'package:pb_app/modals.dart';
import 'package:pocketbase/pocketbase.dart';

final client = PocketBase(Config.baseUrl);

class Workflows {
  static Future<UserAuth> authenticate() {
    return client.users.authViaEmail(
      Config.testEmail,
      Config.testPassword,
    );
  }

  static Future<ResultList<RecordModel>> getAndroidSubmissions({int page = 1}) {
    return client.records.getList(
      "android_submissions",
      page: page,
      perPage: 20,
      sort: "-created_at",
      query: {'expand': 'created_by_profile'},
    );
  }

  static Future<void> createAndroidSubmission(BuildContext context) async {
    final isLoggedIn = client.authStore.isValid;

    /// If we're not logged in, show login modal
    if (!isLoggedIn) {
      LoginModal.show(context);
    }

    /// If we're logged in, show android submission form
    if (isLoggedIn) {
      // TODO:
      // Modals.showSubmissionModal(context);

    }
  }
}
