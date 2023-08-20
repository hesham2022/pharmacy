import 'package:chefaa/core/utils/search_params.dart';
import 'package:chefaa/modeules/User/auth/data/models/rating_stats.dart';
import 'package:chefaa/modeules/User/auth/data/models/review_reponse.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/pharmacy_reponse.dart';

import '../../../../../../core/api_config/api_client.dart';
import '../../../../../../core/api_config/api_constants.dart';
import '../../domain/entities/create_review_params.dart';
import '../../domain/entities/get_reviews_params.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

abstract class IUserRemote {
  IUserRemote(this.apiConfig);
  final ApiClient apiConfig;

  Future<User> getMe();
  Future<User> getUser(String id);
  Future<User> getPharmacyByUser(String id);
  Future<User> follow(String id);
  Future<User> unFollow(String id);

  Future<User> getProvider(String id);
  Future<List<User>> getNearPharmacies(
      {required Map<String, dynamic> body,
      required Map<String, dynamic> query});
  Future<List<User>> getTopPharmacies(
      {required Map<String, dynamic> body,
      required Map<String, dynamic> query});
  Future<List<User>> getNearPharmaciesWith24(
      {required Map<String, dynamic> body,
      required Map<String, dynamic> query});
  Future<List<User>> getOurDoctors();

  Future<User> updateUser(Map<String, dynamic> body);
  Future<User> updateProvider(Map<String, dynamic> body);

  Future<User> updateUserDetails(Map<String, dynamic> body);
  Future<User> uploadAttachment(Map<String, dynamic> body);
  Future<User> uploadProviderAttachment(Map<String, dynamic> body);
  Future<User> deleteProviderAttachment(String id);
  Future<User> deleteUserAttachment(String id);

  Future<User> uploadUserPhoto(Map<String, dynamic> body);
  Future<User> uploadProviderPhoto(Map<String, dynamic> body);
  // Pharmacy Daetials
  Future<List<RatingStats>> getRatingStats(String id);
  // review
  Future<ReviewResponse> getReviews(GetReviewParams id);
  Future<Review> createReview(CreateReviewParams params);
  Future<PharmaciesResponse> search(SearchParams params);
}

class UserRemote extends IUserRemote {
  UserRemote(super.apiConfig);

  @override
  Future<User> getMe() async {
    final response = await apiConfig.get(kGetMe);

    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data);
    return userResult;
  }

  @override
  Future<User> getUser(String id) async {
    final response = await apiConfig.get(kUsers + id);
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data);
    return userResult;
  }

  @override
  Future<User> getProvider(String id) async {
    final response = await apiConfig.get(kProviders + id);
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data);
    return userResult;
  }

  @override
  Future<User> updateUser(Map<String, dynamic> body) async {
    final response = await apiConfig.patch(kUpdateMe, body: body);
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data);
    return userResult;
  }

  @override
  Future<User> updateProvider(Map<String, dynamic> body) async {
    final response = await apiConfig.patch(kUpadetProvider, body: body);
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data);
    return userResult;
  }

  @override
  Future<User> updateUserDetails(Map<String, dynamic> body) async {
    final response = await apiConfig
        .patch(kUpdateMe, body: <String, dynamic>{'details': body});
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data);
    return userResult;
  }

  @override
  Future<User> uploadAttachment(Map<String, dynamic> body) async {
    final response = await apiConfig.upload(kUUploadAttachment, body: body);
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    return userResult;
  }

  @override
  Future<User> uploadUserPhoto(Map<String, dynamic> body) async {
    final response = await apiConfig.upload(kUUploadUserPhoto, body: body);
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data);
    return userResult;
  }

  @override
  Future<User> uploadProviderPhoto(Map<String, dynamic> body) async {
    final response = await apiConfig.upload(kUploadProviderPhoto, body: body);
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data);
    return userResult;
  }

  @override
  Future<User> uploadProviderAttachment(Map<String, dynamic> body) async {
    final response =
        await apiConfig.upload(kUploadProviderAttachment, body: body);
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    return userResult;
  }

  @override
  Future<User> deleteProviderAttachment(String id) async {
    final response = await apiConfig
        .patch(kDeleteProviderAttachment, body: <String, dynamic>{'id': id});
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    return userResult;
  }

  @override
  Future<User> deleteUserAttachment(String id) async {
    final response = await apiConfig
        .patch(kDeleteUserAttachment, body: <String, dynamic>{'id': id});
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    return userResult;
  }

  @override
  Future<List<User>> getOurDoctors() {
    // TODO: implement getOurDoctors
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getNearPharmacies(
      {required Map<String, dynamic> body,
      required Map<String, dynamic> query}) async {
    final response =
        await apiConfig.post(kNear, body: body, queryParams: query);
    final data = response.data as List;
    // ignore: avoid_dynamic_calls
    final userResult =
        data.map((e) => UserModel.fromJson(e as Map<String, dynamic>)).toList();
    return userResult;
  }

  @override
  Future<User> follow(String id) async {
    final response = await apiConfig.post(followUrll(id));
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data);
    return userResult;
  }

  @override
  Future<User> getPharmacyByUser(String id) async {
    final response = await apiConfig.get(getPharmacyByUserUrl(id));
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data);
    return userResult;
  }

  @override
  Future<User> unFollow(String id) async {
    final response = await apiConfig.post(unfollowUrll(id));
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data);
    return userResult;
  }

  @override
  Future<List<User>> getNearPharmaciesWith24(
      {required Map<String, dynamic> body,
      required Map<String, dynamic> query}) async {
    final response =
        await apiConfig.post(kWith24, body: body, queryParams: query);
    final data = response.data as List;
    // ignore: avoid_dynamic_calls
    final userResult =
        data.map((e) => UserModel.fromJson(e as Map<String, dynamic>)).toList();
    return userResult;
  }

  @override
  Future<List<User>> getTopPharmacies(
      {required Map<String, dynamic> body,
      required Map<String, dynamic> query}) async {
    final response =
        await apiConfig.post(kTop5, body: body, queryParams: query);
    final data = response.data as List;
    // ignore: avoid_dynamic_calls
    final userResult =
        data.map((e) => UserModel.fromJson(e as Map<String, dynamic>)).toList();
    return userResult;
  }

  @override
  Future<List<RatingStats>> getRatingStats(String id) async {
    final response = await apiConfig.get(kGetRatingStating(id));
    // ignore: avoid_dynamic_calls
    return (response.data as List<dynamic>)
        .map((e) => RatingStats.fromJson(e))
        .toList();
  }

  @override
  Future<ReviewResponse> getReviews(GetReviewParams id) async {
    final response = await apiConfig.get(kReview, queryParams: id.toQuery());
    return ReviewResponse.fromJson(response.data);
  }

  @override
  Future<Review> createReview(CreateReviewParams params) async {
    final response = await apiConfig.post(kReview, body: params.toJson());
    return Review.fromJson(response.data);
  }

  @override
  Future<PharmaciesResponse> search(SearchParams params) async {
    final response =
        await apiConfig.get(kSearch, queryParams: params.toQuery());
    return PharmaciesResponse.fromJson(response.data);
  }
}
