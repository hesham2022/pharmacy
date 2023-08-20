import 'package:dartz/dartz.dart';

import '../../../../../../core/api_errors/network_exceptions.dart';
import '../../../../../../core/useCase/use_case.dart';
import '../entities/update_user_params.dart';
import '../entities/user.dart';
import '../repositories/i_user.dart';

class UpdateProvider extends UseCase<User, UpdateUserParams> {
  UpdateProvider(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, User>> call(UpdateUserParams params) async {
    return repository.updateProvider(params);
  }
}
