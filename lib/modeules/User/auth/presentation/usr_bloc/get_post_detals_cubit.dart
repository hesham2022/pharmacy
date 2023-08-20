import 'package:chefaa/core/api_errors/index.dart';
import 'package:chefaa/modeules/User/auth/data/models/post_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_posts.dart';

abstract class GetPostDetailsState extends Equatable {}

class GetPostDetailsStateIntitial extends GetPostDetailsState {
  @override
  List<Object?> get props => [];
}

class GetPostDetailsStateLoading extends GetPostDetailsState {
  @override
  List<Object?> get props => [];
}

class GetPostDetailsStateLoaded extends GetPostDetailsState {
  final Post post;

  GetPostDetailsStateLoaded(this.post);
  @override
  List<Object?> get props => [post];
}

class PostLikeStet extends GetPostDetailsState {
  final Post post;

  PostLikeStet(this.post);
  @override
  List<Object?> get props => [post];
}

class GetPostDetailsStateError extends GetPostDetailsState {
  final NetworkExceptions error;

  GetPostDetailsStateError(this.error);
  @override
  List<Object?> get props => [];
}

class GetPostDetailsCubit extends Cubit<GetPostDetailsState> {
  GetPostDetailsCubit(this.getPostDetailsU, this.likePostU)
      : super(GetPostDetailsStateIntitial());
  final GetPostDetailsU getPostDetailsU;
  final LikePostU likePostU;

  Future<void> getPostDetails(String id) async {
    emit(GetPostDetailsStateLoading());
    final result = await getPostDetailsU(id);
    result.fold((l) => emit(GetPostDetailsStateError(l)),
        (r) => emit(GetPostDetailsStateLoaded(r)));
  }

  Future<void> likePost(String id) async {
    // emit(GetPostDetailsStateLoading());
    final result = await likePostU(id);
    result.fold(
        (l) => emit(GetPostDetailsStateError(l)), (r) => emit(PostLikeStet(r)));
  }
}
