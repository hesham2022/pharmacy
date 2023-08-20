import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../../../core/api_config/api_client.dart';
import '../../../../../../core/api_errors/app_error.dart';
import '../../../../../../core/api_errors/network_exceptions.dart';
import '../entities/forget_password_params.dart';
import '../entities/login_param.dart';
import '../entities/reset_password_params.dart';
import '../entities/sign_param.dart';
import '../entities/sign_provider_params.dart';
import '../entities/verify_password_params.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  signUpSucess
}

abstract class IAuthenticationRepository {
  IAuthenticationRepository({required this.apiConfig});
  final ApiClient apiConfig;

  StreamController<AuthenticationStatus> get controller;

  Stream<AuthenticationStatus> get status;

  Future<Either<AppError, void>> logIn(LoginParam loginParams);
  Future<Either<AppError, void>> logibProvider(LoginParam loginParams);

  Future<Either<AppError, void>> signIn(SignParam signParams);
  Future<Either<AppError, void>> signProvider(
      RegisterProviderParams signParams);

  Future<Either<NetworkExceptions, String>> forgotPassword(
    ForgetPasswordParam forgetPasswordParam,
  );
  Future<Either<NetworkExceptions, String>> forgotPasswordFirebase(
    ForgetPasswordParam forgetPasswordParam,
  );
  Future<Either<NetworkExceptions, String>> changephone(
    ForgetPasswordParam forgetPasswordParam,
  );
  Future<Either<NetworkExceptions, String>> sendOtp();
  Future<Either<NetworkExceptions, String>> verifyForgetPasswordOtp(
    VerifyForgetPasswordParam verifyForgetPasswordParam,
  );
  Future<Either<NetworkExceptions, String>> verifyChangephoneOtp(
    VerifyForgetPasswordParam verifyForgetPasswordParam,
  );
  Future<Either<NetworkExceptions, void>> verifyOtp(
    VerifyForgetPasswordParam verifyForgetPasswordParam,
  );
  Future<Either<NetworkExceptions, void>> verifyOtpFirebase();
  Future<Either<NetworkExceptions, void>> resetPassword(
    ResetPasswordParams verifyForgetPasswordParam,
  );
  Future<Either<NetworkExceptions, void>> resetPasswordFirebase(
    ResetPasswordParams verifyForgetPasswordParam,
  );
  Future<Either<NetworkExceptions, void>> resetphone(
    ResetPasswordParams verifyForgetPasswordParam,
  );
  Future<Either<NetworkExceptions, void>> resetphoneFiebase(
    ResetPasswordParams verifyForgetPasswordParam,
  );
  // Future<Either<NetworkExceptions, void>> updatePassword(
  //   UpdatePasswordParam updatePasswordParam,
  // );
  Future<void> logOut();

  void dispose() => controller.close();
}
