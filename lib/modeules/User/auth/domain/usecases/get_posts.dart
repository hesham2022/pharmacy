import 'package:chefaa/modeules/User/auth/data/models/post_response.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/create_post_params.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/get_post_params.dart';
import 'package:chefaa/modeules/User/auth/domain/repositories/i_post_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/api_errors/network_exceptions.dart';
import '../../../../../core/useCase/use_case.dart';

class GetPostsU extends UseCase<PostResponse, GetPostParams> {
  GetPostsU(this.repository);
  final IPostRepository repository;

  @override
  Future<Either<NetworkExceptions, PostResponse>> call(GetPostParams id) async {
    return repository.getPost(id);
  }
}

class GetPostDetailsU extends UseCase<Post, String> {
  GetPostDetailsU(this.repository);
  final IPostRepository repository;

  @override
  Future<Either<NetworkExceptions, Post>> call(String id) async {
    return repository.getPostDetails(id);
  }
}

class LikePostU extends UseCase<Post, String> {
  LikePostU(this.repository);
  final IPostRepository repository;

  @override
  Future<Either<NetworkExceptions, Post>> call(String id) async {
    return repository.likePost(id);
  }
}

class CreaetPostU extends UseCase<Post, CreatePostParams> {
  CreaetPostU(this.repository);
  final IPostRepository repository;

  @override
  Future<Either<NetworkExceptions, Post>> call(CreatePostParams id) async {
    return repository.createPost(id);
  }
}
