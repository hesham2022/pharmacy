// To parse this JSON data, do
//
//     final chatsResponse = chatsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chefaa/modeules/User/Messages_Screen/chat_mode.dart';

ChatsResponse chatsResponseFromJson(String str) =>
    ChatsResponse.fromJson(json.decode(str));

class ChatsResponse {
  ChatsResponse({
    required this.results,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.totalResults,
  });

  List<ChatModel> results;
  int page;
  int limit;
  int totalPages;
  int totalResults;

  factory ChatsResponse.fromJson(Map<String, dynamic> json) => ChatsResponse(
        results: List<ChatModel>.from(
            json["results"].map((x) => ChatModel.fromJson(x))),
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        totalResults: json["totalResults"],
      );
}
