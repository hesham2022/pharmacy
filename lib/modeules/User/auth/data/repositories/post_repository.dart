import 'package:chefaa/modeules/User/auth/data/models/post_response.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/create_post_params.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/get_post_params.dart';
import 'package:chefaa/modeules/User/auth/domain/repositories/i_post_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../../core/api_errors/network_exceptions.dart';
import '../../../../../../core/utils/catch_async.dart';
import '../datasources/post_remote.dart';

class PostRepository extends IPostRepository {
  PostRepository(this.postRemote);
  final IPostRemote postRemote;

  @override
  Future<Either<NetworkExceptions, PostResponse>> getPost(
      GetPostParams params) async {
    return guardFuture<PostResponse>(
      () async => postRemote.getPosts(params),
    );
  }

  @override
  Future<Either<NetworkExceptions, Post>> getPostDetails(String id) async {
    return guardFuture<Post>(
      () async => postRemote.getPostDetails(id),
    );
  }

  @override
  Future<Either<NetworkExceptions, Post>> likePost(String id) async {
    return guardFuture<Post>(
      () async => postRemote.likePost(id),
    );
  }

  @override
  Future<Either<NetworkExceptions, Post>> createPost(
      CreatePostParams params) async {
    return guardFuture<Post>(
      () async => postRemote.createPost(params),
    );
  }
}
