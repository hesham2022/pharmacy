import 'package:dartz/dartz.dart';

import '../../../../../../core/api_errors/network_exceptions.dart';
import '../../../../../../core/useCase/use_case.dart';
import '../entities/upload_attachment_params.dart';
import '../entities/user.dart';
import '../repositories/i_user.dart';

class UploadUserAttachments extends UseCase<User, UploadAttachmentParams> {
  UploadUserAttachments(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, User>> call(
    UploadAttachmentParams params,
  ) async {
    return repository.uploadUserAttatchment(params);
  }
}
