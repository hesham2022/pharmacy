class ReviewResponse {
  List<Review>? results;
  int? page;
  int? limit;
  int? totalPages;
  int? totalResults;

  ReviewResponse(
      {this.results,
      this.page,
      this.limit,
      this.totalPages,
      this.totalResults});

  ReviewResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Review>[];
      json['results'].forEach((v) {
        results!.add(new Review.fromJson(v));
      });
    }
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    totalResults = json['totalResults'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['totalPages'] = this.totalPages;
    data['totalResults'] = this.totalResults;
    return data;
  }
}

class Review {
  String? review;
  String? pharmacy;
  double? rating;
  UserR? user;
  DateTime? createdAt;
  String? id;

  Review(
      {this.review,
      this.pharmacy,
      this.rating,
      this.user,
      this.createdAt,
      this.id});

  Review.fromJson(Map<String, dynamic> json) {
    review = json['review'];
    pharmacy = json['pharmacy'];
    rating = (json['rating'] as num).toDouble();
    user = json['user'] != null ? new UserR.fromJson(json['user']) : null;
    createdAt = DateTime.tryParse(json['createdAt']??'');
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review'] = this.review;
    data['pharmacy'] = this.pharmacy;
    data['rating'] = this.rating;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

class UserR {
  String? name;
  String? id;

  UserR({this.name, this.id});

  UserR.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
