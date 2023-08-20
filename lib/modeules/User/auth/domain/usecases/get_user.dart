import 'package:dartz/dartz.dart';

import '../../../../../../core/api_errors/network_exceptions.dart';
import '../../../../../../core/useCase/use_case.dart';
import '../entities/user.dart';
import '../repositories/i_user.dart';

class GetUser extends UseCase<User, String> {
  GetUser(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, User>> call(String params) async {
    return repository.getUser(params);
  }
}

class GetProvider extends UseCase<User, String> {
  GetProvider(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, User>> call(String params) async {
    return repository.getProvider(params);
  }
}
