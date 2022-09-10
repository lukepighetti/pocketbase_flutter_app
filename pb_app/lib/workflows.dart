import 'package:pb_app/secrets.dart';
import 'package:pocketbase/pocketbase.dart';

final client = PocketBase('http://127.0.0.1:8090');

class AppWorkflows {
  Future<UserAuth> authenticate() {
    return client.users.authViaEmail(
      Secrets.email,
      Secrets.password,
    );
  }

  Future<ResultList<RecordModel>> getAndroidSubmissions({int page = 1}) {
    return client.records.getList(
      "android_submissions",
      page: page,
      perPage: 20,
      sort: "-created_at",
      query: {'expand': 'created_by_profile'},
    );
  }
}
