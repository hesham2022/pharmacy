class CreateReviewParams {
  CreateReviewParams({
    required this.review,
    required this.pharmacy,
    required this.rating,
  });

  final String? review;
  final String? pharmacy;
  final double? rating;

  factory CreateReviewParams.fromJson(Map<String, dynamic> json) {
    return CreateReviewParams(
      review: json["review"],
      pharmacy: json["pharmacy"],
      rating: json["rating"],
    );
  }

  Map<String, dynamic> toJson() => {
        "review": review,
        "pharmacy": pharmacy,
        "rating": rating,
      };
}
