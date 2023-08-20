import 'package:chefaa/core/api_errors/index.dart';
import 'package:chefaa/modeules/User/auth/data/models/review_reponse.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/create_review_params.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_near.dart';

abstract class CreateReviewState extends Equatable {}

class CreateReviewIntial extends CreateReviewState {
  List<Object?> get props => [];
}

class CreateReviewLoading extends CreateReviewState {
  @override
  List<Object?> get props => [];
}

class CreateReviewLoaded extends CreateReviewState {
  final Review reviews;

  CreateReviewLoaded(this.reviews);
  List<Object?> get props => [reviews];
}

class CreateReviewError extends CreateReviewState {
  final NetworkExceptions error;

  CreateReviewError(this.error);
  @override
  List<Object?> get props => [error];
}

class CreateReviewCubit extends Cubit<CreateReviewState> {
  CreateReviewCubit({required this.CreateReviewU})
      : super(CreateReviewIntial());
  final CreateReviewsU CreateReviewU;

  Future<void> CreateReview(CreateReviewParams params) async {
    emit(CreateReviewLoading());
    final result = await CreateReviewU(params);
    // await Future.delayed(Duration(seconds: 2));
    result.fold((l) => emit(CreateReviewError(l)), (r) {
      emit(CreateReviewLoaded(r));
    });
  }
}
