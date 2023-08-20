import '../../../../../../core/api_errors/network_exceptions.dart';

abstract class ChangephoneFirebaseState {}

class ChangephoneFirebaseStateIntial extends ChangephoneFirebaseState {}

class ChangephoneFirebaseStateLoading extends ChangephoneFirebaseState {}

class ChangephoneFirebaseStateError extends ChangephoneFirebaseState {
  ChangephoneFirebaseStateError(this.error);
  final NetworkExceptions error;
}

class ChangephoneFirebaseStateResetTokenLoaded
    extends ChangephoneFirebaseState {
  ChangephoneFirebaseStateResetTokenLoaded(this.token);
  final String token;
}

class ChangephoneFirebaseStateResetPasswordSuccess
    extends ChangephoneFirebaseState {}

class ChangephoneFirebaseStateChangephoneFirebaseTokenLoaded
    extends ChangephoneFirebaseState {
  ChangephoneFirebaseStateChangephoneFirebaseTokenLoaded(
    this.phoneFirebase,
  );
  final String phoneFirebase;
}
