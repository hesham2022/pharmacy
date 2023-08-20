import 'package:chefaa/modeules/User/auth/data/models/rating_stats.dart';
import 'package:chefaa/modeules/User/auth/data/models/review_reponse.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/create_review_params.dart';
import 'package:dartz/dartz.dart';

import '../../../../../../core/api_errors/network_exceptions.dart';
import '../../../../../core/utils/search_params.dart';
import '../entities/get_near_params.dart';
import '../entities/get_reviews_params.dart';
import '../entities/pharmacy_reponse.dart';
import '../entities/ulpoad_provider_attachments_params.dart';
import '../entities/update_user_params.dart';
import '../entities/upload_attachment_params.dart';
import '../entities/upload_user_photo_params.dart';
import '../entities/user.dart';

// ignore: one_member_abstracts
abstract class IUserRepository {
  Future<Either<NetworkExceptions, User>> getMe();
  Future<Either<NetworkExceptions, User>> getUser(String id);
  Future<Either<NetworkExceptions, User>> updateUser(UpdateUserParams params);
  Future<Either<NetworkExceptions, User>> updateProvider(
    UpdateUserParams params,
  );
  Future<Either<NetworkExceptions, User>> getPharmacyByUser(String id);
  Future<Either<NetworkExceptions, User>> follow(String id);
  Future<Either<NetworkExceptions, User>> unFollow(String id);

  Future<Either<NetworkExceptions, User>> getProvider(String id);

  Future<Either<NetworkExceptions, List<User>>> getOurDoctors();
  Future<Either<NetworkExceptions, List<User>>> geteNear(GetNearParams params);
  Future<Either<NetworkExceptions, List<User>>> getTopNear(
      GetNearParams params);
  Future<Either<NetworkExceptions, List<User>>> getNearwith24(
      GetNearParams params);

 

  Future<Either<NetworkExceptions, User>> uploadUserAttatchment(
    UploadAttachmentParams params,
  );
  Future<Either<NetworkExceptions, User>> uploadProviderAttatchment(
    UploadPorviderAttachmentParams params,
  );
  Future<Either<NetworkExceptions, User>> deleteProviderAttatchment(
    String params,
  );
  Future<Either<NetworkExceptions, User>> deleteUserAttatchment(
    String params,
  );
  Future<Either<NetworkExceptions, User>> uploadUserPhoto(
    UploadUserPhotoParams params,
  );
  Future<Either<NetworkExceptions, User>> uploadProviderPhoto(
    UploadUserPhotoParams params,
  );
  // Ratting details
  Future<Either<NetworkExceptions, List<RatingStats>>> getRatingStats(
      String id);
  // reviews
  Future<Either<NetworkExceptions, ReviewResponse>> getReviews(
      GetReviewParams id);
  Future<Either<NetworkExceptions, Review>> createReview(
      CreateReviewParams params);
      Future<Either<NetworkExceptions, PharmaciesResponse>> search(
      {required SearchParams params});
}
