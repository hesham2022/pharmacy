// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

UserModel userModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str) as Map<String, dynamic>);

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends User {
  const UserModel(
      {
      // required super.details,
      required super.role,
      required super.isEmailVerified,
      required super.isOtpVerified,
      required super.name,
      required super.fcm,
      super.email,
      super.phone,
      required super.id,
      super.mainPhoto,
      super.hours24,
      super.followers,
      super.address,
      super.photos,
      super.pharmacyName,
      super.isFollowed,
      super.followCount,
      super.distance,
      super.ratingsAverage,
      super.ratingsQuantity});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        role: json['role'] as String,
        followCount: json['followCount'] as int?,
        isFollowed: json['isFollowed'] as bool?,
        isEmailVerified: (json['isEmailVerified'] as bool?) ?? false,
        isOtpVerified: (json['isOtpVerified'] as bool?) ?? false,
        name: json['name'] as String,
        email: json['email'] as String?,
        fcm: (json['fcm'] as String?) ?? '',
        mainPhoto: json['mainPhoto'] as String?,
        phone: json['phone'] as String?,
        distance: json['distance'] == null
            ? null
            : (json['distance'] is int
                ? (json['distance'] as int).toDouble()
                : json['distance'] as double),
        ratingsAverage: ((json['ratingsAverage'] as num?) ?? 0).toDouble(),
        ratingsQuantity: (json['ratingsQuantity'] as int?),
        address: json['address'] == null
            ? null
            : Address.fromJson(json['address'] as Map<String,
                dynamic>), // birthOfDate: DateTime.parse(json['birthOfDate'] as String),
        id: json['id'] != null ? json['id'] as String : json['_id'] as String,
        pharmacyName: json['pharmacyName'] as String?,
        photos: json['photos'] == null
            ? null
            : (json['photos'] as List<dynamic>)
                .map((e) => e as String)
                .toList(),
        followers: json['followers'] == null
            ? null
            : List.from(json['followers'] as List<dynamic>)
                .map((e) => e as String)
                .toList(),
        hours24: json['hours24'] as bool?);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'role': role,
      'isEmailVerified': isEmailVerified,
      'isOtpVerified': isOtpVerified,
      'name': name,
      'email': email,
      'phone': phone,
      'mainPhoto': mainPhoto,
      'id': id,
    };
    if (address != null) map['address'] = address!.toJson();
    return map;
  }
}

Address addressFromJson(String str) =>
    Address.fromJson(json.decode(str) as Map<String, dynamic>);

String addressToJson(Address data) => json.encode(data.toJson());

class Address extends Equatable {
  Address(
      {required this.coordinates,
      required this.governorate,
      required this.id,
      required this.region,
      required this.details});

  factory Address.fromJson(dynamic json) {
    return Address(
      coordinates: List<double>.from(
        (json['coordinates'] as List<dynamic>).map<dynamic>(
          (dynamic x) {
            return double.tryParse(x.toString()) as double;
          },
        ),
      ),
      region: json['region'] as String,
      governorate: json['governorate'] as String,
      id: json['_id'] as String? ?? '',
      details: json['details'] as String,
    );
  }

  final List<double> coordinates;
  final String governorate;
  final String region;
  final String details;

  final String id;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'coordinates': List<dynamic>.from(coordinates.map<double>((x) => x)),
        'governorate': governorate,
        'type': 'Point',
        'details': details,
        'region': region
      };

  @override
  List<Object?> get props => [details, governorate];

  Address copyWith({
    List<double>? coordinates,
    String? governorate,
    String? region,
    String? details,
    String? id,
  }) {
    return Address(
      id: id ?? this.id,
      coordinates: coordinates ?? this.coordinates,
      governorate: governorate ?? this.governorate,
      region: region ?? this.region,
      details: details ?? this.details,
    );
  }
}
