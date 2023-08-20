
import 'package:dartz/dartz.dart';

import 'package:dartz/dartz.dart';


import '../../../../../../core/api_errors/network_exceptions.dart';
import '../../../../../../core/useCase/use_case.dart';
import '../entities/upload_user_photo_params.dart';
import '../entities/user.dart';
import '../repositories/i_user.dart';


class UploadProviderPhoto extends UseCase<User, UploadUserPhotoParams> {
  UploadProviderPhoto(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, User>> call(
    UploadUserPhotoParams params,
  ) async {
    return repository.uploadProviderPhoto(params);
  }
}
