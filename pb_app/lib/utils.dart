import 'package:pocketbase/pocketbase.dart';

String pbFileUrl({
  required String collectionIdOrName,
  required String recordId,
  required String filename,
  String baseUrl = 'http://127.0.0.1:8090',
}) {
  return '$baseUrl/api/files/$collectionIdOrName/$recordId/$filename';
}

extension RecordModelX on RecordModel {
  String resolveFileUrl(String fieldKey) {
    return pbFileUrl(
      collectionIdOrName: collectionId,
      recordId: id,
      filename: data[fieldKey],
    );
  }
}

extension RecordMapX on Map<String, dynamic> {
  String resolveFileUrl(String fieldKey) {
    return pbFileUrl(
      collectionIdOrName: this['@collectionId'],
      recordId: this['id'],
      filename: this[fieldKey],
    );
  }
}
