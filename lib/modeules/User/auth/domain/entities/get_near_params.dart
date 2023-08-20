import 'dart:convert';

import 'package:flutter/foundation.dart';

class GetNearParams {
  final double lat;
  final double lon;
  final Map<String, dynamic> queryParams;
  GetNearParams({
    required this.lat,
    required this.lon,
    required this.queryParams,
  });

  GetNearParams copyWith({
    double? lat,
    double? lon,
    Map<String, dynamic>? queryParams,
  }) {
    return GetNearParams(
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      queryParams: queryParams ?? this.queryParams,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'coordinates': [lon, lat],
    };
  }

  factory GetNearParams.fromMap(Map<String, dynamic> map) {
    return GetNearParams(
      lat: map['lat']?.toDouble() ?? 0.0,
      lon: map['lon']?.toDouble() ?? 0.0,
      queryParams: Map<String, dynamic>.from(map['queryParams']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetNearParams.fromJson(String source) =>
      GetNearParams.fromMap(json.decode(source));

  @override
  String toString() =>
      'GetNearParams(lat: $lat, lon: $lon, queryParams: $queryParams)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetNearParams &&
        other.lat == lat &&
        other.lon == lon &&
        mapEquals(other.queryParams, queryParams);
  }

  @override
  int get hashCode => lat.hashCode ^ lon.hashCode ^ queryParams.hashCode;
}
