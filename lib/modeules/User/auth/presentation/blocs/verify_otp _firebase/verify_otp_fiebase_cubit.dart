import 'package:bloc/bloc.dart';
import 'package:chefaa/modeules/User/auth/presentation/blocs/verify_otp%20_firebase/verify_otp_firebase_state.dart';

import '../../../domain/repositories/i_repository.dart';


class VerifyOtpFirebaseCubit extends Cubit<VerifyOtpFirebaseState> {
  VerifyOtpFirebaseCubit({
    required IAuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(VerifyOtpFirebaseStateIntial());
  final IAuthenticationRepository _authenticationRepository;

  Future<void> verifyOtpFirebase() async {
    emit(VerifyOtpFirebaseStateLoading());
    final result = await _authenticationRepository.verifyOtpFirebase();
    result.fold(
      (l) => emit(VerifyOtpFirebaseStateError(l)),
      (r) => emit(VerifyOtpFirebaseStatedSuccess()),
    );
  }
}
