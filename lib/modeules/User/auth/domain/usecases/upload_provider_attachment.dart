import 'package:dartz/dartz.dart';

import '../../../../../../core/api_errors/network_exceptions.dart';
import '../../../../../../core/useCase/use_case.dart';
import '../entities/ulpoad_provider_attachments_params.dart';
import '../entities/user.dart';
import '../repositories/i_user.dart';

class UploadProviderAttachments
    extends UseCase<User, UploadPorviderAttachmentParams> {
  UploadProviderAttachments(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, User>> call(
    UploadPorviderAttachmentParams params,
  ) async {
    return repository.uploadProviderAttatchment(params);
  }
}

class DeleteProviderAttachments extends UseCase<User, String> {
  DeleteProviderAttachments(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, User>> call(
    String params,
  ) async {
    
    return repository.deleteProviderAttatchment(params);
  }
}

class DeleteUserAttachments extends UseCase<User, String> {
  DeleteUserAttachments(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, User>> call(
    String params,
  ) async {
  
    return repository.deleteUserAttatchment(params);
  }
}
