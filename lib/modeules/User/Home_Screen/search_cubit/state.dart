import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../auth/domain/entities/user.dart';
enum GetpharmaciesPharmacies { initial, loading, loaded, error }

class GetpharmaciesState extends Equatable {
  final List<User> pharmacies;
  final GetpharmaciesPharmacies status;
  final String error;
  final int page;
  final bool reached;
  final bool byCat;
  final String lastCatId;

  GetpharmaciesState(
      {required this.pharmacies,
      this.error = '',
      this.reached = false,
      required this.status,
      this.byCat = false,
      this.lastCatId = '',
      this.page = 0});

  @override
  List<Object?> get props =>
      [pharmacies, status, error, reached, byCat, lastCatId, page];

  GetpharmaciesState copyWith(
      {List<User>? pharmacies,
      GetpharmaciesPharmacies? status,
      String? error,
      int? page,
      String? lastCatId,
      bool? byCat,
      bool? reached}) {
    return GetpharmaciesState(
        pharmacies: pharmacies ?? this.pharmacies,
        status: status ?? this.status,
        error: error ?? this.error,
        page: page ?? this.page,
        byCat: byCat ?? this.byCat,
        lastCatId: lastCatId ?? this.lastCatId,
        reached: reached ?? this.reached);
  }
}
