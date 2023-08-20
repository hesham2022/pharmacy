import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../../../core/utils/attachment_url_helper.dart';


class UploadPorviderAttachmentParams {
  UploadPorviderAttachmentParams({
    required this.attachment,
    required this.title,
  });

  final String attachment;
  final String title;
  Future<Map<String, dynamic>> toMap() async {
    print(title);
    return <String, dynamic>{
      'attachment': await MultipartFile.fromFile(
        attachment,
        contentType: MediaType.parse(getMimeType(attachment)!),
      ),
      'title': title
    };
  }
}
