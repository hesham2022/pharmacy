import '../../../../../../core/api_config/api_client.dart';
import '../../../../../../core/api_config/api_constants.dart';
import '../../domain/entities/signup_response.dart';
import '../models/signup_response_mdeol.dart';

abstract class IAuthRemotDataSource {
  IAuthRemotDataSource(this.apiClient);
  final ApiClient apiClient;
//firebase
  Future<SignUpResponse?> login(Map<String, dynamic> body);
  Future<SignUpResponse?> loginProvider(Map<String, dynamic> body);

  Future<SignUpResponse?> signUp(Map<String, dynamic> body);
  Future<SignUpResponse?> signUpProvider(
    Map<String, dynamic> body,
  );
  Future<void> logoOtt();
  Future<String> forgotPassword(Map<String, dynamic> body);
  Future<String> forgotPasswordFirebase(Map<String, dynamic> body);

  Future<String> changephone(Map<String, dynamic> body);

  Future<String> verifyForgotPassword(Map<String, dynamic> body);

  Future<String> verifyChangephone(Map<String, dynamic> body);

  Future<void> verifyOtp(Map<String, dynamic> body);
  Future<void> verifyOtpFirebase();

  Future<void> resetPassword(Map<String, dynamic> body);
  Future<void> resetPasswordFirebase(Map<String, dynamic> body);

  Future<void> resetphone(Map<String, dynamic> body);
  Future<void> resetphoneFiebase(Map<String, dynamic> body);

  Future<String> sendOtp();
}

class AuthRemotDataSource extends IAuthRemotDataSource {
  AuthRemotDataSource(super.apiConfig);

  @override
  Future<SignUpResponse?> login(Map<String, dynamic> body) async {
    final response = await apiClient.post(kLogin, body: body);
    final loginResponse =
        SignUpResponseModel.fromJson(response.data as Map<String, dynamic>);

    return loginResponse;
  }

  @override
  Future<SignUpResponse?> loginProvider(Map<String, dynamic> body) async {
    final response = await apiClient.post(kLoginProvider, body: body);
    final loginResponse =
        SignUpResponseModel.fromJson(response.data as Map<String, dynamic>);
    return loginResponse;
  }

  @override
  Future<void> logoOtt() {
    throw UnimplementedError();
  }

  @override
  Future<SignUpResponse?> signUp(Map<String, dynamic> body) async {
    final response = await apiClient.postUpload(kRegister, body: body);

    final signInResponse =
        SignUpResponseModel.fromJson(response.data as Map<String, dynamic>);

    return signInResponse;
  }

  @override
  Future<String> forgotPassword(Map<String, dynamic> body) async {
    final response = await apiClient.post(kForgotPassword, body: body);
    return response.data['forgetPasswordToken'] as String;
  }

  @override
  Future<String> forgotPasswordFirebase(Map<String, dynamic> body) async {
    final response = await apiClient.post(kForgotPasswordFirebase, body: body);
    return response.data['forgetPasswordToken'] as String;
  }

  @override
  Future<String> changephone(Map<String, dynamic> body) async {
    final response = await apiClient.post(kChangephone, body: body);
    return response.data['forgetPasswordToken'] as String;
  }

  @override
  Future<String> sendOtp() async {
    final response = await apiClient.post(kSendOtp);
    return response.data['verifyOtpToken'] as String;
  }

  @override
  Future<String> verifyForgotPassword(Map<String, dynamic> body) async {
    final response = await apiClient.post(kverifyForgotPassword, body: body);
    return response.data['resetPasswordToken'] as String;
  }

  @override
  Future<String> verifyChangephone(Map<String, dynamic> body) async {
    final response = await apiClient.post(kverifyChangephone, body: body);
    return response.data['resetPasswordToken'] as String;
  }

  @override
  Future<void> verifyOtp(Map<String, dynamic> body) async {
    await apiClient.post(kVerifyOtp, body: body);
  }

  @override
  Future<void> verifyOtpFirebase() async {
    await apiClient.post(kVerifyOtpFirebase);
  }

  @override
  Future<void> resetPassword(Map<String, dynamic> body) async {
    await apiClient.post(kResetPassword, body: body);
  }

  @override
  Future<void> resetPasswordFirebase(Map<String, dynamic> body) async {
    await apiClient.post(kResetPasswordFirebase, body: body);
  }

  @override
  Future<void> resetphone(Map<String, dynamic> body) async {
    await apiClient.post(kResetphone, body: body);
  }

  @override
  Future<void> resetphoneFiebase(Map<String, dynamic> body) async {
    await apiClient.post(kResetphoneFirebase, body: body);
  }

  @override
  Future<SignUpResponse?> signUpProvider(Map<String, dynamic> body) async {

    final response = await apiClient.postUpload(kRegisterProvider, body: body);

    final signInResponse =
        SignUpResponseModel.fromJson(response.data as Map<String, dynamic>);

    return signInResponse;
  }
}
