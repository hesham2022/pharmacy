import 'package:chefaa/modeules/User/auth/domain/entities/create_post_params.dart';

import '../../../../../../core/api_config/api_client.dart';
import '../../../../../../core/api_config/api_constants.dart';
import '../../domain/entities/get_post_params.dart';
import '../models/post_response.dart';

abstract class IPostRemote {
  IPostRemote(this.apiConfig);
  final ApiClient apiConfig;

  Future<PostResponse> getPosts(GetPostParams id);
  Future<Post> getPostDetails(String id);
  Future<Post> likePost(String id);

  Future<Post> createPost(CreatePostParams params);
}

class PostRemote extends IPostRemote {
  PostRemote(super.apiConfig);

  @override
  Future<PostResponse> getPosts(GetPostParams id) async {
    final response = await apiConfig.get(kPost, queryParams: id.toQuery());
    return PostResponse.fromJson(response.data);
  }

  @override
  Future<Post> getPostDetails(String id) async {
    final response = await apiConfig.get(
      kPost + '/' + id,
    );
    return Post.fromJson(response.data);
  }

  @override
  Future<Post> likePost(String id) async {
    final response = await apiConfig.post(
      kPost + '/like?post=' + id,
    );
    return Post.fromJson(response.data);
  }

  @override
  Future<Post> createPost(CreatePostParams params) async {
    final response =
        await apiConfig.postUpload(kPost, body: await params.toMap());
    return Post.fromJson(response.data);
  }
}
