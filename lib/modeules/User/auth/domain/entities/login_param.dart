// To parse this JSON data, do
//
//     final loginParam = loginParamFromMap(jsonString);

import 'dart:convert';

class LoginParam {
  LoginParam({
    required this.password,
    this.email,
    this.phone,
  });
  factory LoginParam.fromJson(String str) =>
      LoginParam.fromMap(json.decode(str) as Map<String, dynamic>);

  factory LoginParam.fromMap(Map<String, dynamic> json) => LoginParam(
        password: json['password'] as String,
        email: json['email'] as String,
      );
  String toJson() => json.encode(toMap());

  final String password;
  final String? phone;

  final String? email;

  LoginParam copyWith({
    String? password,
    String? email,
  }) =>
      LoginParam(
        password: password ?? this.password,
        email: email ?? this.email,
      );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'password': password,
      // 'fcm': PushNotifications.fcmToken ?? ''
    };
    if (email != null) {
      if (email!.isNotEmpty) {
        map.addAll(<String, dynamic>{'email': email});
      }
    }
    if (phone != null) {
      if (phone!.isNotEmpty) {
        map.addAll(<String, dynamic>{'phone': phone});
      }
    }
    return map;
  }
}
