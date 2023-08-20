import 'package:chefaa/core/api_errors/index.dart';
import 'package:chefaa/modeules/User/auth/data/models/review_reponse.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/get_reviews_params.dart';
import '../../domain/usecases/get_near.dart';

abstract class GetReviewsState extends Equatable {}

class GetReviewsIntial extends GetReviewsState {
  List<Object?> get props => [];
}

class GetReviewsLoading extends GetReviewsState {
  @override
  List<Object?> get props => [];
}

class GetReviewsLoaded extends GetReviewsState {
  final List<Review> reviews;

  GetReviewsLoaded(this.reviews);
  List<Object?> get props => [reviews];
}

class GetReviewsAtFirst extends GetReviewsState {
  final Review review;

  GetReviewsAtFirst(this.review);
  List<Object?> get props => [review];
}

class GetReviewsError extends GetReviewsState {
  final NetworkExceptions error;

  GetReviewsError(this.error);
  @override
  List<Object?> get props => [error];
}

class GetReviewsCubit extends Cubit<GetReviewsState> {
  GetReviewsCubit({required this.getReviewsU}) : super(GetReviewsIntial());
  final GetReviewsU getReviewsU;
  int page = 1;
  bool reached = false;
  Future<void> getReviews(String id) async {
    if (reached == true) return;

    emit(GetReviewsLoading());
    final result =
        await getReviewsU(GetReviewParams(id: id, limit: 10, page: page));
    // await Future.delayed(Duration(seconds: 2));
    result.fold((l) => emit(GetReviewsError(l)), (r) {
      page++;
      if (r.totalPages == page) {
        reached = true;
      }
      emit(GetReviewsLoaded([...r.results!]));
    });
  }

  Future<void> addReviewAtFirsy(Review review) async {
    emit(GetReviewsAtFirst(review));
  }
}
