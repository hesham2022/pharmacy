import 'dart:convert';

class PharmacyNoitifcationModel {
  final String? id;
  final String? user;
  final String? post;
  final String? title;
  final String? body;
  PharmacyNoitifcationModel({
    this.id,
    this.user,
    this.post,
    this.date,
    this.title,
    this.body,
  });
  final DateTime? date;
  PharmacyNoitifcationModel copyWith({
    String? id,
    String? user,
    String? post,
  }) {
    return PharmacyNoitifcationModel(
      id: id ?? this.id,
      user: user ?? this.user,
      post: post ?? this.post,
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      'id': id,
      'user': user,
      'post': post,
      'title': title,
      'body': body,
      'date': date == null ? DateTime.now() : date!.toIso8601String()
    };
    print(map);
    return map;
  }

  factory PharmacyNoitifcationModel.fromMap(Map<dynamic, dynamic> map) {
    print(map);
    return PharmacyNoitifcationModel(
        id: map['id'] ?? '',
        user: map['user'],
        post: map['post'],
        title: map['title'],
        body: map['body'],
        date: (map['date'] is DateTime)
            ? map['date']
            : DateTime.tryParse(map['date']));
  }

  String toJson() => json.encode(toMap());

  factory PharmacyNoitifcationModel.fromJson(String source) =>
      PharmacyNoitifcationModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'PharmacyNoitifcationModel(id: $id, user: $user, post: $post)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PharmacyNoitifcationModel &&
        other.id == id &&
        other.user == user &&
        other.post == post;
  }

  @override
  int get hashCode => id.hashCode ^ user.hashCode ^ post.hashCode;
}
