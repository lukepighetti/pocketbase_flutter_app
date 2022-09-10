import 'package:pb_app/utils.dart';
import 'package:pocketbase/pocketbase.dart';

class AndroidSubmissionDto {
  AndroidSubmissionDto.fromRecord(this._record);

  late final Map<String, dynamic> _data = _record.data;

  final RecordModel _record;

  late final String name = _data['name'];

  late final bool approved = _data['approved'];

  late final String lockScreenFilename = _data['lock_screen'];

  late final String lockScreenUrl = _record.resolveFileUrl(lockScreenFilename);

  late final String homeScreenFilename = _data['home_screen'];

  late final String homeScreenUrl = _record.resolveFileUrl(homeScreenFilename);

  late final ProfileDto createdBy =
      ProfileDto.fromJson(_record.expand['created_by_profile']);
}

class ProfileDto {
  ProfileDto.fromJson(this._data);

  final Map<String, dynamic> _data;

  late final String id = _data['id'];

  late final String avatarUrl = _data.resolveFileUrl(_data['avatar']);

  late final String name = _data['name'];

  late final String userId = _data['userId'];
}
