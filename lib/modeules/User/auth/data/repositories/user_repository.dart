import 'package:chefaa/core/utils/search_params.dart';
import 'package:chefaa/modeules/User/auth/data/models/rating_stats.dart';
import 'package:chefaa/modeules/User/auth/data/models/review_reponse.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/create_review_params.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/get_near_params.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/pharmacy_reponse.dart';
import 'package:dartz/dartz.dart';

import '../../../../../../core/api_errors/network_exceptions.dart';
import '../../../../../../core/utils/catch_async.dart';
import '../../domain/entities/get_reviews_params.dart';
import '../../domain/entities/ulpoad_provider_attachments_params.dart';
import '../../domain/entities/update_user_params.dart';
import '../../domain/entities/upload_attachment_params.dart';
import '../../domain/entities/upload_user_photo_params.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/i_user.dart';
import '../datasources/user_remote.dart';

class UserRepository extends IUserRepository {
  UserRepository(this.userRemote);
  final IUserRemote userRemote;

  @override
  Future<Either<NetworkExceptions, User>> getMe() =>
      guardFuture<User>(userRemote.getMe);
  @override
  Future<Either<NetworkExceptions, User>> getUser(String id) =>
      guardFuture<User>(() => userRemote.getUser(id));
  @override
  Future<Either<NetworkExceptions, User>> getProvider(String id) =>
      guardFuture<User>(() => userRemote.getProvider(id));
  @override
  Future<Either<NetworkExceptions, User>> updateUser(UpdateUserParams params) {
    return guardFuture<User>(() => userRemote.updateUser(params.toMap()));
  }

  @override
  Future<Either<NetworkExceptions, User>> updateProvider(
    UpdateUserParams params,
  ) {
    return guardFuture<User>(() => userRemote.updateProvider(params.toMap()));
  }

  @override
  Future<Either<NetworkExceptions, User>> uploadUserAttatchment(
    UploadAttachmentParams params,
  ) async {
    return guardFuture<User>(
      () async => userRemote.uploadAttachment(await params.toMap()),
    );
  }

  @override
  Future<Either<NetworkExceptions, User>> uploadUserPhoto(
    UploadUserPhotoParams params,
  ) {
    return guardFuture<User>(
      () async => userRemote.uploadUserPhoto(await params.toMap()),
    );
  }

  @override
  Future<Either<NetworkExceptions, User>> uploadProviderPhoto(
    UploadUserPhotoParams params,
  ) {
    return guardFuture<User>(
      () async => userRemote.uploadProviderPhoto(await params.toMap()),
    );
  }

  @override
  Future<Either<NetworkExceptions, User>> deleteProviderAttatchment(
    String params,
  ) {
    return guardFuture<User>(
      () async => userRemote.deleteProviderAttachment(params),
    );
  }

  @override
  Future<Either<NetworkExceptions, User>> deleteUserAttatchment(
    String params,
  ) {
    return guardFuture<User>(
      () async => userRemote.deleteUserAttachment(params),
    );
  }

  @override
  Future<Either<NetworkExceptions, User>> uploadProviderAttatchment(
    UploadPorviderAttachmentParams params,
  ) async {
    return guardFuture<User>(
      () async => userRemote.uploadProviderAttachment(await params.toMap()),
    );
  }

  @override
  Future<Either<NetworkExceptions, List<User>>> getOurDoctors() async {
    return guardFuture<List<User>>(
      () async => userRemote.getOurDoctors(),
    );
  }

  @override
  Future<Either<NetworkExceptions, List<User>>> geteNear(
      GetNearParams params) async {
    return guardFuture<List<User>>(
      () async => userRemote.getNearPharmacies(
          body: params.toMap(), query: params.queryParams),
    );
  }

  @override
  Future<Either<NetworkExceptions, User>> follow(String id) =>
      guardFuture<User>(() => userRemote.follow(id));

  @override
  Future<Either<NetworkExceptions, User>> getPharmacyByUser(String id) =>
      guardFuture<User>(() => userRemote.getPharmacyByUser(id));

  @override
  Future<Either<NetworkExceptions, User>> unFollow(String id) =>
      guardFuture<User>(() => userRemote.unFollow(id));

  @override
  Future<Either<NetworkExceptions, List<User>>> getNearwith24(
      GetNearParams params) async {
    return guardFuture<List<User>>(
      () async => userRemote.getNearPharmaciesWith24(
          body: params.toMap(), query: params.queryParams),
    );
  }

  @override
  Future<Either<NetworkExceptions, List<User>>> getTopNear(
      GetNearParams params) async {
    return guardFuture<List<User>>(
      () async => userRemote.getTopPharmacies(
          body: params.toMap(), query: params.queryParams),
    );
  }

  @override
  Future<Either<NetworkExceptions, List<RatingStats>>> getRatingStats(
      id) async {
    return guardFuture<List<RatingStats>>(
      () async => userRemote.getRatingStats(id),
    );
  }

  @override
  Future<Either<NetworkExceptions, ReviewResponse>> getReviews(
      GetReviewParams id) async {
    return guardFuture<ReviewResponse>(
      () async => userRemote.getReviews(id),
    );
  }

  @override
  Future<Either<NetworkExceptions, Review>> createReview(
      CreateReviewParams params) async {
    return guardFuture<Review>(
      () async => userRemote.createReview(params),
    );
  }

  @override
  Future<Either<NetworkExceptions, PharmaciesResponse>> search(
      {required SearchParams params}) {
    return guardFuture<PharmaciesResponse>(
      () async => userRemote.search(params),
    );
  }
}
