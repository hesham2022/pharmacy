import '../../../../../../core/api_errors/network_exceptions.dart';

abstract class ChangephoneState {}

class ChangephoneStateIntial extends ChangephoneState {}

class ChangephoneStateLoading extends ChangephoneState {}

class ChangephoneStateError extends ChangephoneState {
  ChangephoneStateError(this.error);
  final NetworkExceptions error;
}

class ChangephoneStateResetTokenLoaded extends ChangephoneState {
  ChangephoneStateResetTokenLoaded(this.token);
  final String token;
}

class ChangephoneStateResetPasswordSuccess extends ChangephoneState {}

class ChangephoneStateChangephoneTokenLoaded extends ChangephoneState {
  ChangephoneStateChangephoneTokenLoaded(this.token, this.phone);
  final String token;
  final String phone;
}
