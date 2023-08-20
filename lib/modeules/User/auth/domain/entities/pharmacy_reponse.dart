// To parse this JSON data, do
//
//     final PharmaciesResponse = PharmaciesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chefaa/modeules/User/auth/domain/entities/user.dart';

PharmaciesResponse PharmaciesResponseFromJson(String str) =>
    PharmaciesResponse.fromJson(json.decode(str));

class PharmaciesResponse {
  PharmaciesResponse({
    required this.results,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.totalResults,
  });

  List<User> results;
  int page;
  int limit;
  int totalPages;
  int totalResults;

  factory PharmaciesResponse.fromJson(Map<String, dynamic> json) =>
      PharmaciesResponse(
        results: List<User>.from(json["results"].map((x) => User.fromJson(x))),
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        totalResults: json["totalResults"],
      );
}
