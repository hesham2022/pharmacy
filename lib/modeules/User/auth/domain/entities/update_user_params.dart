import 'dart:convert';

class UpdateUserParams {
  UpdateUserParams({
    this.role,
    this.name,
    this.email,
    this.phone,
    this.birthOfDate,
    this.gender,
    this.fcm,
  });
  factory UpdateUserParams.fromJson(String source) =>
      UpdateUserParams.fromMap(json.decode(source) as Map<String, dynamic>);

  factory UpdateUserParams.fromMap(Map<String, dynamic> map) {
    return UpdateUserParams(
      role: map['role'] as String?,
      name: map['name'] as String?,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      birthOfDate: map['birthOfDate'] != null
          ? DateTime.parse(map['birthOfDate'] as String)
          : null,
      gender: map['gender'] as String?,
    );
  }
  final String? role;

  final String? name;
  final String? email;
  final String? phone;
  final DateTime? birthOfDate;
  final String? gender;
  final String? fcm;

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (role != null) map.addAll(<String, dynamic>{'role': role});
    if (name != null) map.addAll(<String, dynamic>{'name': name});
    if (fcm != null) map.addAll(<String, dynamic>{'fcm': fcm});

    if (email != null) map.addAll(<String, dynamic>{'email': email});
    if (phone != null) {
      map.addAll(<String, dynamic>{'phone': phone});
    }

    if (birthOfDate != null) {
      map.addAll(<String, dynamic>{'birthOfDate': birthOfDate});
    }
    if (gender != null) map.addAll(<String, dynamic>{'gender': gender});

    return map;
  }

  String toJson() => json.encode(toMap());
}
