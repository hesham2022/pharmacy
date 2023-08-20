import 'package:equatable/equatable.dart';

import '../../../../../../core/api_errors/network_exceptions.dart';
import '../../domain/entities/user.dart';

abstract class UserCubitState extends Equatable {}

class UserCubitStateInitil extends UserCubitState {
  @override
  List<Object?> get props => [];
}

class UserCubitStateLoading extends UserCubitState {
  @override
  List<Object?> get props => [];
}

class UserCubitStateLoaded extends UserCubitState {
  UserCubitStateLoaded(this.user);
  final User user;

  @override
  List<Object?> get props => [user];
}

class UserCubitStateError extends UserCubitState {
  UserCubitStateError(this.error);
  final NetworkExceptions error;

  @override
  List<Object?> get props => [error];
}
