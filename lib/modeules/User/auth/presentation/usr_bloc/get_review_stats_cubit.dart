import 'package:chefaa/core/api_errors/index.dart';
import 'package:chefaa/modeules/User/auth/data/models/rating_stats.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_near.dart';

abstract class GetRatingStatsState extends Equatable {}

class GetRatingStatsIntial extends GetRatingStatsState {
  List<Object?> get props => [];
}

class GetRatingStatsLoading extends GetRatingStatsState {
  @override
  List<Object?> get props => [];
}

class GetRatingLoaded extends GetRatingStatsState {
  final List<RatingStats> ratingStats;

  GetRatingLoaded(this.ratingStats);
  List<Object?> get props => [ratingStats];
}

class GetRatingStatsError extends GetRatingStatsState {
  final NetworkExceptions error;

  GetRatingStatsError(this.error);
  @override
  List<Object?> get props => [error];
}

class GetRatingStatsCubit extends Cubit<GetRatingStatsState> {
  GetRatingStatsCubit({required this.getRatingStatsU})
      : super(GetRatingStatsIntial());
  final GetRatingStatsU getRatingStatsU;
  Future<void> getStats(String id) async {
    final result = await getRatingStatsU(id);
    result.fold(
        (l) => emit(GetRatingStatsError(l)), (r) => emit(GetRatingLoaded(r)));
  }
}
