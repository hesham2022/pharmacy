import 'package:bloc/bloc.dart';


import '../../../domain/entities/forget_password_params.dart';
import '../../../domain/entities/reset_password_params.dart';
import '../../../domain/entities/verify_password_params.dart';
import '../../../domain/repositories/i_repository.dart';
import 'change_phone_number_state.dart';

class ChangephoneCubit extends Cubit<ChangephoneState> {
  ChangephoneCubit({
    required IAuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(ChangephoneStateIntial());
  final IAuthenticationRepository _authenticationRepository;
  Future<void> changephone(ForgetPasswordParam param) async {
    emit(ChangephoneStateLoading());
    final result = await _authenticationRepository.changephone(param);
    result.fold(
      (l) => emit(ChangephoneStateError(l)),
      (r) => emit(
        ChangephoneStateChangephoneTokenLoaded(r, param.email),
      ),
    );
  }

  Future<void> verifyChangephoneOtp(
    VerifyForgetPasswordParam param,
  ) async {
    emit(ChangephoneStateLoading());
    final result = await _authenticationRepository.verifyChangephoneOtp(param);
    result.fold(
      (l) => emit(ChangephoneStateError(l)),
      (r) => emit(ChangephoneStateResetTokenLoaded(r)),
    );
  }

  Future<void> resetPassword(ResetPasswordParams param) async {
    emit(ChangephoneStateLoading());
    final result = await _authenticationRepository.resetphone(param);
    result.fold(
      (l) => emit(ChangephoneStateError(l)),
      (r) => emit(ChangephoneStateResetPasswordSuccess()),
    );
  }
}
