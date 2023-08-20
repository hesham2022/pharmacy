import 'package:dartz/dartz.dart';



import '../../../../../../core/api_errors/network_exceptions.dart';
import '../../../../../../core/useCase/use_case.dart';
import '../entities/update_user_params.dart';
import '../entities/user.dart';
import '../repositories/i_user.dart';


class UpdateUser extends UseCase<User, UpdateUserParams> {
  UpdateUser(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, User>> call(UpdateUserParams params) async {
    return repository.updateUser(params);
  }
}
