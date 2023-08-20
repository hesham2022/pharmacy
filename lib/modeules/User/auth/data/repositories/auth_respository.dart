import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../../../core/api_config/api_client.dart';
import '../../../../../../core/api_errors/network_exceptions.dart';
import '../../../../../../core/local_storage/secure_storage_instance.dart';
import '../../../../../../core/local_storage/token_storage.dart';
import '../../../../../../core/utils/catch_async.dart';
import '../../domain/entities/forget_password_params.dart';
import '../../domain/entities/login_param.dart';
import '../../domain/entities/reset_password_params.dart';
import '../../domain/entities/sign_param.dart';
import '../../domain/entities/verify_password_params.dart';
import '../../domain/repositories/i_repository.dart';
import '../datasources/auth_remote.dart';

class AuthenticationRepository extends IAuthenticationRepository {
  AuthenticationRepository({
    required this.authenticationLocalDataSource,
    required this.authRemotDataSource,
    required super.apiConfig,
  }) : _apiConfig = apiConfig;
  final ApiClient _apiConfig;

  final ITokenStorage authenticationLocalDataSource;
  final IAuthRemotDataSource authRemotDataSource;

  @override
  final controller = StreamController<AuthenticationStatus>.broadcast();

  @override
  Stream<AuthenticationStatus> get status async* {
    final token = await authenticationLocalDataSource.getToken();

    if (token == null) {
      yield AuthenticationStatus.unauthenticated;
    } else {
      _apiConfig.init(token);
      yield AuthenticationStatus.authenticated;
      // if (userType == 'user') {
      //   yield AuthenticationStatus.authenticated;
      // }
    }

    yield* controller.stream;
  }

  @override
  Future<Either<NetworkExceptions, void>> logIn(
    LoginParam loginParams,
  ) =>
      guardFuture(
        () async {
          final loginResponse =
              (await authRemotDataSource.login(loginParams.toMap()))!;

          _apiConfig.init(loginResponse.tokens.access.token);
          await authenticationLocalDataSource
              .saveToken(loginResponse.tokens.access.token);
          await Storage.setIsFirst();
          await Storage.setPassword(loginParams.password);
          await Storage.setUserType('user');
          controller.add(AuthenticationStatus.authenticated);
        },
        failureCallBack: () =>
            controller.add(AuthenticationStatus.unauthenticated),
      );
  @override
  Future<Either<NetworkExceptions, void>> logibProvider(
    LoginParam loginParams,
  ) async {
    return guardFuture(
      () async {
        final loginResponse =
            (await authRemotDataSource.loginProvider(loginParams.toMap()))!;

        _apiConfig.init(loginResponse.tokens.access.token);
        await authenticationLocalDataSource
            .saveToken(loginResponse.tokens.access.token);
        await Storage.setIsFirst();
        await Storage.setPassword(loginParams.password);
        await Storage.setUserType('provider');
        controller.add(AuthenticationStatus.authenticated);
      },
      failureCallBack: () =>
          controller.add(AuthenticationStatus.unauthenticated),
    );
  }

  @override
  Future<void> logOut() async {
    await authenticationLocalDataSource.deletToken();
    _apiConfig.init(null);

    controller.add(AuthenticationStatus.unauthenticated);
    await Storage.removePassword();
  }

  @override
  Future<Either<NetworkExceptions, void>> signIn(
    SignParam signParams,
  ) =>
      guardFuture(
        () async {
          final Map<String, dynamic> map = await signParams.toMap();
          final loginResponse = await authRemotDataSource.signUp(map);
          _apiConfig.init(loginResponse!.tokens.access.token);
          // await authenticationLocalDataSource
          //     .saveToken(loginResponse.tokens.access.token);
          await Storage.setIsFirst();
          await Storage.setPassword(signParams.password);
          controller.add(AuthenticationStatus.signUpSucess);
        },
        failureCallBack: () =>
            controller.add(AuthenticationStatus.authenticated),
      );
  @override
  Future<Either<NetworkExceptions, String>> forgotPassword(
    ForgetPasswordParam forgetPasswordParam,
  ) {
    return guardFuture<String>(
      () async {
        return authRemotDataSource.forgotPassword(forgetPasswordParam.toMap());
      },
    );
  }

  @override
  Future<Either<NetworkExceptions, String>> forgotPasswordFirebase(
    ForgetPasswordParam forgetPasswordParam,
  ) {
    return guardFuture<String>(
      () async {
        return authRemotDataSource
            .forgotPasswordFirebase(forgetPasswordParam.toMap());
      },
    );
  }

  @override
  Future<Either<NetworkExceptions, String>> sendOtp() {
    return guardFuture<String>(
      () async {
        return authRemotDataSource.sendOtp();
      },
    );
  }

  @override
  Future<Either<NetworkExceptions, String>> verifyForgetPasswordOtp(
    VerifyForgetPasswordParam verifyForgetPasswordParam,
  ) {
    return guardFuture<String>(
      () async {
        return authRemotDataSource
            .verifyForgotPassword(verifyForgetPasswordParam.toMap());
      },
    );
  }

  @override
  Future<Either<NetworkExceptions, void>> verifyOtp(
    VerifyForgetPasswordParam verifyForgetPasswordParam,
  ) {
    return guardFuture<void>(
      () async {
        return authRemotDataSource.verifyOtp(verifyForgetPasswordParam.toMap());
      },
    );
  }

  @override
  Future<Either<NetworkExceptions, void>> verifyOtpFirebase() {
    return guardFuture<void>(
      () async {
        return authRemotDataSource.verifyOtpFirebase();
      },
    );
  }

  @override
  Future<Either<NetworkExceptions, void>> resetPassword(
    ResetPasswordParams verifyForgetPasswordParam,
  ) {
    return guardFuture<void>(
      () async {
        return authRemotDataSource
            .resetPassword(verifyForgetPasswordParam.toMap());
      },
    );
  }

  @override
  Future<Either<NetworkExceptions, void>> resetPasswordFirebase(
    ResetPasswordParams verifyForgetPasswordParam,
  ) {
    return guardFuture<void>(
      () async {
        return authRemotDataSource
            .resetPasswordFirebase(verifyForgetPasswordParam.toMap());
      },
    );
  }

  @override
  Future<Either<NetworkExceptions, String>> changephone(
    ForgetPasswordParam forgetPasswordParam,
  ) {
    return guardFuture<String>(
      () async {
        return authRemotDataSource.changephone(forgetPasswordParam.toMap());
      },
    );
  }

  @override
  Future<Either<NetworkExceptions, void>> resetphone(
    ResetPasswordParams verifyForgetPasswordParam,
  ) {
    return guardFuture<void>(
      () async {
        return authRemotDataSource
            .resetphone(verifyForgetPasswordParam.toMap());
      },
    );
  }

  @override
  Future<Either<NetworkExceptions, void>> resetphoneFiebase(
    ResetPasswordParams verifyForgetPasswordParam,
  ) {
    return guardFuture<void>(
      () async {
        return authRemotDataSource.resetphoneFiebase(<String, dynamic>{
          'password': '+2${verifyForgetPasswordParam.password}'
        });
      },
    );
  }

  @override
  Future<Either<NetworkExceptions, String>> verifyChangephoneOtp(
    VerifyForgetPasswordParam verifyForgetPasswordParam,
  ) {
    return guardFuture<String>(
      () async {
        return authRemotDataSource
            .verifyChangephone(verifyForgetPasswordParam.toMap());
      },
    );
  }

  @override
  Future<Either<NetworkExceptions, void>> signProvider(
    signParams,
  ) =>
      guardFuture(
        () async {
          final Map<String, dynamic> map = await signParams.toMap();
          final loginResponse = await authRemotDataSource.signUpProvider(map);
          _apiConfig.init(loginResponse!.tokens.access.token);
          await authenticationLocalDataSource
              .saveToken(loginResponse.tokens.access.token);
          await Storage.setIsFirst();
          await Storage.setPassword(signParams.password);
          await Storage.setUserType('company');
          controller.add(AuthenticationStatus.signUpSucess);
        },
        failureCallBack: () =>
            controller.add(AuthenticationStatus.authenticated),
      );
}
