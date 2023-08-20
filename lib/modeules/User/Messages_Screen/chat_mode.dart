import 'package:chefaa/modeules/User/auth/data/models/user_model.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  ChatModel({this.pharmacy, this.user, this.id});
  ChatModel.fromJson(Map<String, dynamic> json) {
    pharmacy = UserModel.fromJson(json['pharmacy']);
    user = UserModel.fromJson(json['user']);
    id = json['id'] as String;
    print(json['messages']);
    if (json['messages'] != null) {
      for (final v in json['messages'] as List<dynamic>) {
        messages.add(Messages.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  User? pharmacy;
  User? user;
  String? id;
  final List<Messages> messages = [];

  @override
  List<Object?> get props => [user, pharmacy, id, messages];
}

class Messages extends Equatable {
  Messages({
    this.senderType,
    this.senderId,
    this.chat,
    this.text,
    this.id,
    this.mediaType,
    this.mediaUrl,
    this.mediaThumbUrl,
    this.mediaName,
    this.mediaSize,
    this.mediaDuration,
    required this.time,
  });
  factory Messages.fromJson(
    Map<String, dynamic> json,
  ) {
    print('__________json $json');
    return Messages(
      senderType: json['senderType'] as String,
      senderId: json['senderId'] as String,
      chat: json['chat'] == null
          ? json['chatId'] as String?
          : json['chat'] as String,
      text: json['text'] as String,
      mediaType: json['mediaType'] as String?,
      mediaUrl: json['mediaUrl'] as String?,
      mediaThumbUrl: json['mediaThumbUrl'] as String?,
      mediaName: json['mediaName'] as String?,
      mediaSize: json['mediaSize'] as int?,
      mediaDuration: json['mediaDuration'] as int?,
      id: json['id'] as String,
      time: DateTime.parse(json['time'] as String),
    );
    //createdAt
  }
  String? senderType;
  String? senderId;
  String? chat;
  String? text;
  String? id;
  String? mediaType;
  String? mediaUrl;
  String? mediaThumbUrl;
  String? mediaName;
  int? mediaSize;
  int? mediaDuration;
  String? get mediaUrlOrText {
    if (mediaUrl != null && mediaUrl!.isNotEmpty) {
      return mediaUrl;
    } else {
      return text;
    }
  }

  final DateTime time;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['senderType'] = senderType;
    data['senderId'] = senderId;
    data['chat'] = chat;
    data['text'] = text;
    data['time'] = time;
    data['mediaType'] = mediaType;
    data['mediaUrl'] = mediaUrl;
    data['mediaThumbUrl'] = mediaThumbUrl;
    data['mediaName'] = mediaName;
    data['mediaSize'] = mediaSize;
    data['mediaDuration'] = mediaDuration;

    data['id'] = id;
    return data;
  }

  @override
  List<Object?> get props => [senderId, id, chat, text, mediaUrl, time];
}
