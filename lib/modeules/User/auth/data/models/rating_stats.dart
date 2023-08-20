class RatingStats {
  RatingStats({
    required this.number,
    required this.id,
  });

  final int? number;
  final int? id;

  factory RatingStats.fromJson(Map<String, dynamic> json) {
    return RatingStats(
      number: json["number"],
      id: json["id"],
    );
  }
}
