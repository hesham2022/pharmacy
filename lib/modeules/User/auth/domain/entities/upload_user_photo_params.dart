import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../../../core/utils/attachment_url_helper.dart';

class UploadUserPhotoParams {
  UploadUserPhotoParams({
    required this.photo,
  });

  final String photo;
  Future<Map<String, dynamic>> toMap() async {
    return <String, dynamic>{
      'photo': await MultipartFile.fromFile(
        photo,
        contentType: MediaType.parse(getMimeType(photo)!),
      ),
    };
  }
}
