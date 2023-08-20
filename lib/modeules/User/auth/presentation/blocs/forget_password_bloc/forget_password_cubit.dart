import 'package:bloc/bloc.dart';



import '../../../domain/entities/forget_password_params.dart';
import '../../../domain/entities/reset_password_params.dart';
import '../../../domain/entities/verify_password_params.dart';
import '../../../domain/repositories/i_repository.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit({
    required IAuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(ForgetPasswordStateIntial());
  final IAuthenticationRepository _authenticationRepository;
  Future<void> forgetPassword(ForgetPasswordParam param) async {
    emit(ForgetPasswordStateLoading());
    final result = await _authenticationRepository.forgotPassword(param);
    result.fold(
      (l) => emit(ForgetPasswordStateError(l)),
      (r) => emit(ForgetPasswordStateForgetPasswordTokenLoaded(r)),
    );
  }

  Future<void> verifyForgetPasswordOtp(VerifyForgetPasswordParam param) async {
    emit(ForgetPasswordStateLoading());
    final result =
        await _authenticationRepository.verifyForgetPasswordOtp(param);
    result.fold(
      (l) => emit(ForgetPasswordStateError(l)),
      (r) => emit(ForgetPasswordStateResetTokenLoaded(r)),
    );
  }

  Future<void> resetPassword(ResetPasswordParams param) async {
    emit(ForgetPasswordStateLoading());
    final result = await _authenticationRepository.resetPassword(param);
    result.fold(
      (l) => emit(ForgetPasswordStateError(l)),
      (r) => emit(ForgetPasswordStateResetPasswordSuccess()),
    );
  }
}
