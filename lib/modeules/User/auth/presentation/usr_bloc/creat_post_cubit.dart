import 'package:chefaa/modeules/User/auth/domain/entities/create_post_params.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/get_near_params.dart';
import 'package:chefaa/modeules/User/auth/domain/usecases/get_near.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/api_errors/network_exceptions.dart';
import '../../data/models/post_response.dart';
import '../../domain/usecases/get_posts.dart';

abstract class CreatePostState extends Equatable {}

class CreatePostStateInitil extends CreatePostState {
  @override
  List<Object?> get props => [];
}

class CreatePostStateLoading extends CreatePostState {
  @override
  List<Object?> get props => [];
}

class CreatePostStateError extends CreatePostState {
  CreatePostStateError(this.error);
  final NetworkExceptions error;
  @override
  List<Object?> get props => [];
}

class CreatePostStateLoaded extends CreatePostState {
  CreatePostStateLoaded(this.post);
  final Post post;

  @override
  List<Object?> get props => [post];
}

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit({
    required this.creaetPostU,
  }) : super(CreatePostStateInitil());
  final CreaetPostU creaetPostU;
  Future<void> createPost(CreatePostParams params) async {
    emit(CreatePostStateLoading());
    final result = await creaetPostU(params);
    result.fold(
      (l) => emit(CreatePostStateError(l)),
      (r) {
        emit(CreatePostStateLoaded(r));
      },
    );
  }
}

