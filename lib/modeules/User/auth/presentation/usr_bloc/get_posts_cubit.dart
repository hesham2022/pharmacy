import 'package:chefaa/modeules/User/auth/domain/entities/get_post_params.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/post_response.dart';
import '../../domain/usecases/get_posts.dart';

enum GetPostsStatus { initial, loading, loaded, error }

class GetPostsState extends Equatable {
  final List<Post> posts;
  final GetPostsStatus status;
  final String error;
  final int page;
  final bool reached;
  GetPostsState(
      {required this.posts,
      this.error = '',
      this.reached = false,
      required this.status,
      this.page = 1});

  @override
  List<Object?> get props => [posts, status, error, reached];

  GetPostsState copyWith(
      {List<Post>? posts,
      GetPostsStatus? status,
      String? error,
      int? page,
      bool? reached}) {
    return GetPostsState(
        posts: posts ?? this.posts,
        status: status ?? this.status,
        error: error ?? this.error,
        page: page ?? this.page,
        reached: reached ?? this.reached);
  }
}

class GetPostsCubit extends Cubit<GetPostsState> {
  GetPostsCubit({required this.getPostsU})
      : super(GetPostsState(
          posts: [],
          status: GetPostsStatus.initial,
        ));
  final GetPostsU getPostsU;
  int page = 1;
  bool reached = false;
  Future<void> getPosts(String id) async {
    if (state.reached == true) return;

    emit(state.copyWith(status: GetPostsStatus.loading));
    final result =
        await getPostsU(GetPostParams(id: id, limit: 10, page: page));
    // await Future.delayed(Duration(seconds: 2));
    result.fold(
        (l) => emit(state.copyWith(
            status: GetPostsStatus.error, error: l.errorMessege)), (r) {
      emit(state.copyWith(
          posts: [...state.posts, ...r.results!],
          page: state.page + 1,
          status: GetPostsStatus.loaded,
          reached: r.totalPages == page));
    });
  }

  Future<void> addReviewAtFirsy(Post post) async {
    emit(state.copyWith(posts: [post, ...state.posts]));
  }
}
