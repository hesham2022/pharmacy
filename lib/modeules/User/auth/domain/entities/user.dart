//ignore_for_file: constant_identifier_names
import 'package:chefaa/modeules/User/auth/presentation/blocs/auth_bloc/authentication_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user_model.dart';

class User extends Equatable {
  const User(
      {required this.role,
      required this.isEmailVerified,
      required this.isOtpVerified,
      required this.name,
      this.email,
      this.phone,
      required this.fcm,
      required this.id,
      this.address,
      this.mainPhoto,
      this.hours24,
      this.followers,
      this.photos,
      this.pharmacyName,
      this.ratingsAverage,
      this.ratingsQuantity,
      this.isFollowed,
      this.followCount,
      this.distance});
  static User empty = User(
    name: '',
    role: 'user',
    id: '',
    phone: '',
    isEmailVerified: false,
    fcm: '',
    isOtpVerified: false,
    // birthOfDate: DateTime.now(),
  );
  final String role;
  final bool isEmailVerified;

  final bool isOtpVerified;
  final String name;
  final String? mainPhoto;
  final String fcm;
  final String? email;
  final String? phone;
  final String id;
  final bool? isFollowed;
  final int? followCount;
  final Address? address;
  //
  final bool? hours24;
  final List<String>? followers;
  final List<String>? photos;
  final String? pharmacyName;
  final double? distance;
  final double? ratingsAverage;
  final int? ratingsQuantity;
  bool get isUser => role == 'user';
  bool get isPharmacy => role == 'pharmacy';

  factory User.fromJson(Map<String, dynamic> json) {
    print(json);
    return User(
      role: json['role'] as String,
      isEmailVerified: json['isEmailVerified'] as bool,
      isOtpVerified: (json['isOtpVerified'] ?? false) as bool,
      name: json['name'] as String,
      mainPhoto: json['mainPhoto'] as String?,
      fcm: (json['fcm'] ?? '') as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      id: json['id'] as String,
      isFollowed: json['isFollowed'] as bool?,
      followCount: json['followCount'] as int?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      hours24: json['hours24'] as bool?,
      followers: json['followers'] == null
          ? null
          : (json['followers'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      photos: json['photos'] == null
          ? null
          : (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
      pharmacyName: json['pharmacyName'] as String?,
      distance: json['distance'] as double?,
      ratingsAverage: json['ratingsAverage'] is double
          ? json['ratingsAverage'] as double?
          : (json['ratingsAverage'] ?? 0.0).toDouble(),
      ratingsQuantity: (json['ratingsQuantity'] ?? 0) as int?,
    );
  }
  static User getUser(BuildContext context) {
    return context.read<AuthenticationBloc>().state.user;
  }

  @override
  List<Object?> get props => [name, email, phone];

  User copyWith({
    Address? address,
    String? role,
    bool? isEmailVerified,
    bool? isOtpVerified,
    String? name,
    String? fcm,
    String? email,
    String? phone,
    String? id,
    String? mainPhoto,
    bool? hours24,
    List<String>? followers,
    List<String>? photos,
    String? pharmacyName,
    int? ratingsQuantity,
    double? ratingsAverage,
    double? distance,
    int? followCount,
    bool? isFollowed,
  }) {
    return User(
        isFollowed: isFollowed ?? this.isFollowed,
        followCount: followCount ?? this.followCount,
        hours24: hours24 ?? this.hours24,
        followers: followers ?? this.followers,
        photos: photos ?? this.photos,
        pharmacyName: pharmacyName ?? this.pharmacyName,
        role: role ?? this.role,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        isOtpVerified: isOtpVerified ?? this.isOtpVerified,
        name: name ?? this.name,
        mainPhoto: mainPhoto ?? this.mainPhoto,
        fcm: fcm ?? this.fcm,
        address: address ?? this.address,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        id: id ?? this.id,
        distance: distance ?? this.distance,
        ratingsAverage: ratingsAverage ?? this.ratingsAverage,
        ratingsQuantity: ratingsQuantity ?? this.ratingsQuantity);
  }
}
