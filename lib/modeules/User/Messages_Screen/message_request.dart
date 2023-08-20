import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class MessageRequest {
  final String? file;
  final String? mediaType;
  MessageRequest({
    this.mediaType,
    this.file,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['file'] = file;
    return data;
  }

  Future<Map<String, dynamic>> toUpload() async {
    if (mediaType == 'image')
      return await toUploadImage();
    else if (mediaType == 'video')
      return await toUploadVideo();
    else if (mediaType == 'audio')
      return await toUploadAudio();
    else
      return await toUploadImage();
  }

  Future<Map<String, dynamic>> toUploadImage() async {
    final data = <String, dynamic>{};

    if (file != null)
      data['file'] = await MultipartFile.fromFile(file!,
          contentType: MediaType('image', 'jpg'));
    return data;
  }

  Future<Map<String, dynamic>> toUploadVideo() async {
    final data = <String, dynamic>{};

    if (file != null)
      data['file'] = await MultipartFile.fromFile(file!,
          contentType: MediaType('video', 'mp4'));
    return data;
  }

  Future<Map<String, dynamic>> toUploadAudio() async {
    final data = <String, dynamic>{};

    if (file != null)
      data['file'] = await MultipartFile.fromFile(file!,
          contentType: MediaType('audio', 'mp3'));
    return data;
  }

  MessageRequest copyWith({
    String? chat,
    String? text,
    String? file,
    String? mediaType,
  }) {
    return MessageRequest(
      file: file ?? this.file,
      mediaType: mediaType ?? this.mediaType,
    );
  }
}
