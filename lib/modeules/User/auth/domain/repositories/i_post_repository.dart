import 'package:chefaa/modeules/User/auth/domain/entities/create_post_params.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/get_post_params.dart';
import 'package:dartz/dartz.dart';

import '../../../../../../core/api_errors/network_exceptions.dart';
import '../../data/models/post_response.dart';

// ignore: one_member_abstracts
abstract class IPostRepository {
  // posts
  Future<Either<NetworkExceptions, PostResponse>> getPost(GetPostParams params);
  Future<Either<NetworkExceptions, Post>> getPostDetails(String id);
  Future<Either<NetworkExceptions, Post>> likePost(String id);

  Future<Either<NetworkExceptions, Post>> createPost(CreatePostParams params);
}
