class PostResponse {
  List<Post>? results;
  int? page;
  int? limit;
  int? totalPages;
  int? totalResults;

  PostResponse(
      {this.results,
      this.page,
      this.limit,
      this.totalPages,
      this.totalResults});

  PostResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Post>[];
      json['results'].forEach((v) {
        results!.add(new Post.fromJson(v));
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

class Post {
  String? productName;
  String? brand;
  String? description;
  int? quantity;
  String? to;
  String? from;
  String? photo;
  String? pharmacy;
  String? id;
  bool? isLiked;
  int? likes;
  Post(
      {this.productName,
      this.brand,
      this.description,
      this.quantity,
      this.to,
      this.from,
      this.photo,
      this.pharmacy,
      this.isLiked,
      this.likes,
      this.id});

  Post.fromJson(Map<String, dynamic> json) {
    print(json);
    productName = json['productName'];
    brand = json['brand'];
    description = json['description'];
    quantity = json['quantity'];
    to = json['to'];
    from = json['from'];
    likes = json['likes'];
    photo = json['photo'];
    pharmacy = json['pharmacy'];
    id = json['id'];
    isLiked = json['isLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['productName'] = this.productName;
    data['brand'] = this.brand;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['to'] = this.to;
    data['from'] = this.from;
    data['photo'] = this.photo;
    data['pharmacy'] = this.pharmacy;
    data['id'] = this.id;
    data['likes'] = this.likes;
    data['isLiked'] = this.isLiked;
    return data;
  }
}
