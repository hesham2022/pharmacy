import 'dart:convert';

class CreateChatParams {
  CreateChatParams({
    required this.user,
    required this.pharmacy,
  });
  factory CreateChatParams.fromJson(String source) =>
      CreateChatParams.fromMap(json.decode(source) as Map<String, dynamic>);

  factory CreateChatParams.fromMap(Map<String, dynamic> map) {
    return CreateChatParams(
      user: map['user'] as String,
      pharmacy: map['pharmacy'] as String,
    );
  }
  final String user;
  final String pharmacy;

  CreateChatParams copyWith({
    String? user,
    String? pharmacy,
  }) {
    return CreateChatParams(
      user: user ?? this.user,
      pharmacy: pharmacy ?? this.pharmacy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user,
      'pharmacy': pharmacy,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'CreateChatParams(user: $user, pharmacy: $pharmacy)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateChatParams &&
        other.user == user &&
        other.pharmacy == pharmacy;
  }

  @override
  int get hashCode => user.hashCode ^ pharmacy.hashCode;
}
