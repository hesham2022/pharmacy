// To parse this JSON data, do
//
//     final loginParam = loginParamFromMap(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../data/models/user_model.dart';

class SignParam {
  SignParam(
      {required this.name,
      required this.password,
      required this.email,
      this.phone,
      required this.photo,
      this.address});

  String toJson() => json.encode(toMap());
  final String name;
  final String password;
  final String email;
  final String? phone;
  final String photo;
  final Address? address;

  SignParam copyWith(
          {String? name,
          String? password,
          String? email,
          String? phone,
          String? jobTitle,
          int? age,
          Address? address,
          String? photo}) =>
      SignParam(
        photo: photo ?? this.photo,
        name: name ?? this.name,
        password: password ?? this.password,
        email: email ?? this.email,
        address: address ?? this.address,
        phone: phone ?? this.phone,
      );

  Future<Map<String, dynamic>> toMap() async {
    final m = <String, dynamic>{
      'name': name,
      'password': password,

      'fcm': 'fcm',

      'mainPhoto': await MultipartFile.fromFile(
        photo,
        contentType: MediaType('image', 'jpeg'),
      ),
      // 'fcm': PushNotifications.fcmToken ?? ''
    };
    if (email.isNotEmpty) m['email'] = email;
    if (phone != null) m['phone'] = phone;
    if (address != null) m['address'] = address!.toJson();
    return m;
  }
}
