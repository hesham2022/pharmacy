// import 'package:bloc/bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:home_cure/core/api_errors/network_exceptions.dart';
// import 'package:home_cure/features/authentication/domain/entities/entities.dart';
// import 'package:home_cure/features/authentication/domain/repositories/i_repository.dart';
// import 'package:home_cure/features/login/presentation/change_phone_number_fiebase_cubit/change_phone_number_firebase_state.dart';

// class ChangephoneFirebaseCubit
//     extends Cubit<ChangephoneFirebaseState> {
//   ChangephoneFirebaseCubit({
//     required IAuthenticationRepository authenticationRepository,
//   })  : _authenticationRepository = authenticationRepository,
//         super(ChangephoneFirebaseStateIntial());
//   final IAuthenticationRepository _authenticationRepository;
//   String? verificationCode;

//   Future<void> changephone(ForgetPasswordParam param) async {
//     emit(ChangephoneFirebaseStateLoading());
//     await FirebaseAuth.instance.verifyphone(
//       phone: '+2${param.email}',
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         // await FirebaseAuth.instance
//         //     .signInWithCredential(credential)
//         //     .then((value) async {
//         //   if (value.user != null) {

//         //   } else {
//         //     print('not verified');
//         //   }
//         // });
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         print(e.message);

//         emit(ChangephoneFirebaseStateError(NetworkExceptions(e)));
//       },
//       codeSent: (String? verficationID, int? resendToken) {
//         verificationCode = verficationID;
//         emit(
//           ChangephoneFirebaseStateChangephoneFirebaseTokenLoaded(
//             param.email,
//           ),
//         );
//       },
//       codeAutoRetrievalTimeout: (String verificationID) {
//         verificationCode = verificationID;
//       },
//     );
//     // final result = await _authenticationRepository.changephone(param);
//     // result.fold(
//     //   (l) => emit(ChangephoneFirebaseStateError(l)),
//     //   (r) => emit(
//     //     ChangephoneFirebaseStateChangephoneFirebaseTokenLoaded(
//     //       param.email,
//     //     ),
//     //   ),
//     // );
//   }

//   Future<void> resetPassword(ResetPasswordParams param) async {
//     emit(ChangephoneFirebaseStateLoading());
//     final result =
//         await _authenticationRepository.resetphoneFiebase(param);
//     result.fold(
//       (l) => emit(ChangephoneFirebaseStateError(l)),
//       (r) => emit(ChangephoneFirebaseStateResetPasswordSuccess()),
//     );
//   }
// }
