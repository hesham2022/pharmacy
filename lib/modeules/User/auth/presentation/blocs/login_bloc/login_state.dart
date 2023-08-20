import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {}


class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}

class LoginInitial extends LoginState {}
