import 'package:dartz/dartz.dart';


import '../../../../../../core/api_errors/network_exceptions.dart';
import '../../../../../../core/useCase/use_case.dart';
import '../entities/user.dart';
import '../repositories/i_user.dart';


class GetMe extends UseCase<User, NoParams> {
  GetMe(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, User>> call(NoParams params) async {
    return repository.getMe();
  }
}
