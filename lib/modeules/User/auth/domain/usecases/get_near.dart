import 'package:chefaa/core/utils/search_params.dart';
import 'package:chefaa/modeules/User/Messages_Screen/message_request.dart';
import 'package:chefaa/modeules/User/Messages_Screen/upload_message_media_reposne.dart';
import 'package:chefaa/modeules/User/auth/data/models/review_reponse.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/create_review_params.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/get_near_params.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/pharmacy_reponse.dart';
import 'package:chefaa/modeules/User/auth/domain/repositories/i_chat_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../../core/api_errors/network_exceptions.dart';
import '../../../../../../core/useCase/use_case.dart';
import '../../data/models/rating_stats.dart';
import '../entities/get_reviews_params.dart';
import '../entities/user.dart';
import '../repositories/i_user.dart';

class GetNearU extends UseCase<List<User>, GetNearParams> {
  GetNearU(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, List<User>>> call(
      GetNearParams params) async {
    return repository.geteNear(params);
  }
}

class GetTopNearU extends UseCase<List<User>, GetNearParams> {
  GetTopNearU(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, List<User>>> call(
      GetNearParams params) async {
    return repository.getTopNear(params);
  }
}

class GetNearWith24U extends UseCase<List<User>, GetNearParams> {
  GetNearWith24U(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, List<User>>> call(
      GetNearParams params) async {
    return repository.getNearwith24(params);
  }
}

class GetPharmacyByUser extends UseCase<User, String> {
  GetPharmacyByUser(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, User>> call(String id) async {
    return repository.getPharmacyByUser(id);
  }
}

class FollowPharmacy extends UseCase<User, String> {
  FollowPharmacy(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, User>> call(String id) async {
    return repository.follow(id);
  }
}

class UnFollowPharmacy extends UseCase<User, String> {
  UnFollowPharmacy(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, User>> call(String id) async {
    return repository.unFollow(id);
  }
}

class GetRatingStatsU extends UseCase<List<RatingStats>, String> {
  GetRatingStatsU(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, List<RatingStats>>> call(String id) async {
    return repository.getRatingStats(id);
  }
}

class GetReviewsU extends UseCase<ReviewResponse, GetReviewParams> {
  GetReviewsU(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, ReviewResponse>> call(
      GetReviewParams id) async {
    return repository.getReviews(id);
  }
}

class CreateReviewsU extends UseCase<Review, CreateReviewParams> {
  CreateReviewsU(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, Review>> call(
      CreateReviewParams params) async {
    return repository.createReview(params);
  }
}

class UploadMessageMedia extends UseCase<UploadMediaResponse, MessageRequest> {
  UploadMessageMedia(this.repository);
  final IChatRespository repository;

  @override
  Future<Either<NetworkExceptions, UploadMediaResponse>> call(
      MessageRequest params) async {
    return repository.uploadMessage(params);
  }
}

class SearchPharmaciesU extends UseCase<PharmaciesResponse, SearchParams> {
  SearchPharmaciesU(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, PharmaciesResponse>> call(
      SearchParams params) async {
    return repository.search(params: params);
  }
}
