// {
//   "chat": "641416d7ade471ac18dd76ae",
//   "text": "hello",
//   "mediaUrl": "https://res.cloudinary.com/datbzhwzu/image/upload/v1685203522/vlpncaazducwtecq5mmn.png",
//   "mediaType": "image",
//   "mediaId": "vlpncaazducwtecq5mmn",
//   "mediaFormat": "png",
//   "mediaSize": 143867,
//   "mediaWidth": 1080,
//   "mediaHeight": 1920
// }

class UploadMediaResponse{
  final String? mediaUrl;
  final String? mediaType;
  final String? mediaId;
  final String? mediaFormat;
  final int? mediaSize;
  final int? mediaWidth;
  final int? mediaHeight;
  final String? mediaThumbUrl;
  final int mediaDuration;


  UploadMediaResponse({
    this.mediaUrl,
    this.mediaType,
    this.mediaId,
    this.mediaFormat,
    this.mediaSize,
    this.mediaWidth,
    this.mediaHeight,
    this.mediaThumbUrl,
    this.mediaDuration = 0,
  });

  factory UploadMediaResponse.fromJson(Map<String, dynamic> json) {
    return UploadMediaResponse(
      mediaUrl: json['mediaUrl'] as String?,
      mediaType: json['mediaType'] as String?,
      mediaId: json['mediaId'] as String?,
      mediaFormat: json['mediaFormat'] as String?,
      mediaSize: json['mediaSize'] as int?,
      mediaWidth: json['mediaWidth'] as int?,
      mediaHeight: json['mediaHeight'] as int?,
      mediaThumbUrl: json['mediaThumbUrl'] as String?,
      mediaDuration: json['mediaDuration'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mediaUrl'] = mediaUrl;
    data['mediaType'] = mediaType;
    data['mediaId'] = mediaId;
    data['mediaFormat'] = mediaFormat;
    data['mediaSize'] = mediaSize;
    data['mediaWidth'] = mediaWidth;
    data['mediaHeight'] = mediaHeight;
    data['mediaThumbUrl'] = mediaThumbUrl;
    data['mediaDuration'] = mediaDuration;
    return data;
  }

  
}