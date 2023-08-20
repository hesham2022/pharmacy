import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../../core/utils/fcm_utils.dart';
import '../../data/models/user_model.dart';

class RegisterProviderParams {
  RegisterProviderParams(
      {required this.name,
      required this.email,
      required this.password,
      required this.mainPhoto,
      required this.phone,
      required this.pharmacyName,
      this.photos,
      required this.address});

  final String name;
  final String email;
  final String password;
  final String phone;
  final String pharmacyName;
  final Address address;
  final String mainPhoto;
  final List<String>? photos;
  RegisterProviderParams copyWith(
      {String? name,
      String? email,
      String? gender,
      String? password,
      String? phoneNumber,
      String? mainPhoto,
      String? bio,
      String? managerName,
      String? slugan,
      String? phone,
      String? pharmacyName,
      List<String>? photos,
      Address? address}) {
    return RegisterProviderParams(
        address: address ?? this.address,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        mainPhoto: mainPhoto ?? this.mainPhoto,
        photos: photos ?? this.photos,
        pharmacyName: pharmacyName ?? this.pharmacyName,
        phone: phone ?? this.phone);
  }

  Future<Map<String, dynamic>> toMap() async {
    Future<List<MultipartFile>>? multiparts;
    if (photos != null)
      multiparts = Future.wait([
        for (var i in photos!)
          MultipartFile.fromFile(
            i,
            contentType: MediaType('image', 'jpeg'),
          )
      ]);
    final map = <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'phone': '+2$phone',
      'pharmacyName': pharmacyName,
      'fcm': PushNotifications.fcmToken,
      'mainPhoto': await MultipartFile.fromFile(
        mainPhoto,
        contentType: MediaType('image', 'jpeg'),
      ),
      'address': address.toJson(),
    };
    if (multiparts != null) map['photos'] = await multiparts;
    return map;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'RegisterUserParams(name: $name, email: $email,  password: $password, mainPhoto: $mainPhoto, criminalFish: , address: $address, )';
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterProviderParams &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.mainPhoto == mainPhoto &&
        other.address == address;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        mainPhoto.hashCode ^
        address.hashCode;
  }
}
