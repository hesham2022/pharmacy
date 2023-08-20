import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class CreatePostParams {
  final String photo;
  final List<String> photos;
  final String productName;
  final String brand;
  final String description;
  final int quantity;
  final DateTime form;
  final DateTime to;
  CreatePostParams({
    required this.photo,
    required this.photos,
    required this.productName,
    required this.brand,
    required this.description,
    required this.quantity,
    required this.form,
    required this.to,
  });

  CreatePostParams copyWith({
    String? photo,
    List<String>? photos,
    String? productName,
    String? brand,
    String? description,
    int? quantity,
    DateTime? form,
    DateTime? to,
  }) {
    return CreatePostParams(
      photo: photo ?? this.photo,
      photos: photos ?? this.photos,
      productName: productName ?? this.productName,
      brand: brand ?? this.brand,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      form: form ?? this.form,
      to: to ?? this.to,
    );
  }

  Future<Map<String, dynamic>> toMap() async {
    Future<List<MultipartFile>>? multiparts;
    if (photos.isEmpty)
      multiparts = Future.wait([
        for (var i in photos)
          MultipartFile.fromFile(
            i,
            contentType: MediaType('image', 'jpeg'),
          )
      ]);
    final map = {
      'photo': await MultipartFile.fromFile(
        photo,
        contentType: MediaType('image', 'jpeg'),
      ),
      'productName': productName,
      'brand': brand,
      'description': description,
      'quantity': quantity,
      'from': form.millisecondsSinceEpoch,
      'to': to.millisecondsSinceEpoch,
    };
    if (multiparts != null) map['photos'] = await multiparts;
    return map;
  }

  factory CreatePostParams.fromMap(Map<String, dynamic> map) {
    return CreatePostParams(
      photo: map['photo'] ?? '',
      photos: map['photos'] ?? '',
      productName: map['productName'] ?? '',
      brand: map['brand'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      form: DateTime.fromMillisecondsSinceEpoch(map['form']),
      to: DateTime.fromMillisecondsSinceEpoch(map['to']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreatePostParams.fromJson(String source) =>
      CreatePostParams.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreatePostParams(photo: $photo, photos: $photos, productName: $productName, brand: $brand, description: $description, quantity: $quantity, form: $form, to: $to)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreatePostParams &&
        other.photo == photo &&
        other.photos == photos &&
        other.productName == productName &&
        other.brand == brand &&
        other.description == description &&
        other.quantity == quantity &&
        other.form == form &&
        other.to == to;
  }

  @override
  int get hashCode {
    return photo.hashCode ^
        photos.hashCode ^
        productName.hashCode ^
        brand.hashCode ^
        description.hashCode ^
        quantity.hashCode ^
        form.hashCode ^
        to.hashCode;
  }
}
