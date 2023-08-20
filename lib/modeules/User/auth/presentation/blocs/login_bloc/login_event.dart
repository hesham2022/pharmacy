import 'package:equatable/equatable.dart';

import '../../../../../../core/enums/role.dart';
import '../../../domain/entities/login_param.dart';
import '../../../domain/entities/sign_param.dart';
import '../../../domain/entities/sign_provider_params.dart';


abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class LoginEmailOrPhoneChanged extends LoginEvent {
  const LoginEmailOrPhoneChanged(this.username);
  final String username;

  @override
  List<Object> get props => [username];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class Validate extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoginConfirmPasswordChanged extends LoginEvent {
  const LoginConfirmPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginphoneChanged extends LoginEvent {
  const LoginphoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

class LoginGenderhanged extends LoginEvent {
  const LoginGenderhanged(this.gender);

  final String gender;

  @override
  List<Object> get props => [gender];
}

class LoginNameChanged extends LoginEvent {
  const LoginNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class ChangeErrorMessage extends LoginEvent {
  const ChangeErrorMessage(this.msg);

  final String msg;

  @override
  List<Object> get props => [msg];
}

class ResetFields extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted(this.loginParam, this.role);
  final LoginParam loginParam;
  final Role role;
}

class LoginWithEmail extends LoginEvent {
  const LoginWithEmail({required this.loginWithEmail});
  final bool loginWithEmail;
}

class LoginBirthChanged extends LoginEvent {
  const LoginBirthChanged(this.name);

  final DateTime? name;

  @override
  List<Object> get props => [name!];
}

class LoginProviderSubmitted extends LoginEvent {
  const LoginProviderSubmitted(this.params);
  final RegisterProviderParams params;
}

class LoginRegisterSubmitted extends LoginEvent {
  const LoginRegisterSubmitted(this.param);
  final SignParam param;
}
