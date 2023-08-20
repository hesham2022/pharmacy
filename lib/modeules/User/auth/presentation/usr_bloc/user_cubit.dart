import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/api_errors/network_exceptions.dart';
import '../../domain/entities/update_user_params.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_me.dart';
import '../../domain/usecases/get_user.dart';
import '../../domain/usecases/update_provider.dart';
import '../../domain/usecases/update_user.dart';
import 'user_cubit_state.dart';

class UserCubit extends Cubit<UserCubitState> {
  UserCubit({
    required this.getMe,
    required this.updateUser,
    required this.updateProvider,

    // required this.uploadUserAttatchment,
    // required this.updateUserDetails,
    // required this.uploadProviderAttachments,
    // required this.uploadUserPhoto,
    // required this.updateProvider,
    // required this.uploadProviderPhoto,
    // required this.deleteProviderAttachments,
    // required this.deleteUserAttachments,

    required this.getUser,
  }) : super(UserCubitStateInitil());
  final GetMe getMe;
  final UpdateUser updateUser;
  final GetUser getUser;
  // final UpdateUserDetails updateUserDetails;
  // final UploadUserAttachments uploadUserAttatchment;
  // final UploadUserPhoto uploadUserPhoto;
  // final UploadProviderPhoto uploadProviderPhoto;
  final UpdateProvider updateProvider;
  // final UploadProviderAttachments uploadProviderAttachments;
  // final DeleteProviderAttachments deleteProviderAttachments;
  // final DeleteUserAttachments deleteUserAttachments;

  void addNewUser(User user) {
    currentUser = user;

    emit(UserCubitStateLoaded(user));
  }

  late User currentUser;
  static UserCubit get(BuildContext context) => context.read<UserCubit>();
  Future<void> updateUserFunc(UpdateUserParams params) async {
    print('______________________');
    emit(UserCubitStateLoading());
    final Either<NetworkExceptions, User> user;
    if (currentUser.isUser) {
      user = await updateUser(params);
    } else {
      user = await updateProvider(params);
    }
    user.fold(
      (l) => emit(UserCubitStateError(l)),
      (r) {
        currentUser = r;

        emit(UserCubitStateLoaded(r));
      },
    );
  }

// Future<void> updateUserDeatilsFunc(Details params) async {
//   emit(UserCubitStateLoading());
//   final user = await updateUserDetails(params);
//   user.fold(
//     (l) => emit(UserCubitStateError(l)),
//     (r) {
//       currentUser = r;

//       emit(UserCubitStateLoaded(r));
//     },
//   );
// }

  Future<void> getUserFuc(String params) async {
    emit(UserCubitStateLoading());
    final user = await getUser(params);
    print('________user $user');
    user.fold(
      (l) => emit(UserCubitStateError(l)),
      (r) {
        currentUser = r;

        emit(UserCubitStateLoaded(r));
      },
    );
  }

  // Future<void> uploadUserAttatchmentFunc(UploadAttachmentParams params) async {
  //   emit(UserCubitStateLoading());
  //   final user = await uploadUserAttatchment(params);
  //   user.fold(
  //     (l) {
  //       emit(UserCubitStateError(l));
  //     },
  //     (r) {
  //       currentUser = r;

  //       emit(UserCubitStateLoaded(r));
  //     },
  //   );
  // }

  // Future<void> uploadProviderAttatchmentFunc(
  //   UploadPorviderAttachmentParams params,
  // ) async {
  //   emit(UserCubitStateLoading());
  //   final user = await uploadProviderAttachments(params);
  //   user.fold(
  //     (l) => emit(UserCubitStateError(l)),
  //     (r) {
  //       currentUser = r;

  //       emit(UserCubitStateLoaded(r));
  //     },
  //   );
  // }

  // Future<void> deleteProviderAttatchmentFunc(
  //   String params,
  // ) async {
  //   emit(UserCubitStateLoading());
  //   final user = await deleteProviderAttachments(params);
  //   user.fold(
  //     (l) => emit(UserCubitStateError(l)),
  //     (r) {
  //       currentUser = r;

  //       emit(UserCubitStateLoaded(r));
  //     },
  //   );
  // }

  // Future<void> deleteUserAttatchmentFunc(
  //   String params,
  // ) async {
  //   emit(UserCubitStateLoading());
  //   final user = await deleteUserAttachments(params);
  //   user.fold(
  //     (l) => emit(UserCubitStateError(l)),
  //     (r) {
  //       currentUser = r;

  //       emit(UserCubitStateLoaded(r));
  //     },
  //   );
  // }

  // Future<void> uploadUserPhotoFunc(UploadUserPhotoParams params) async {
  //   // final currentUser = (state as UserCubitStateLoaded).user;

  //   emit(UserCubitStateLoading());
  //   final Either<NetworkExceptions, User> user;
  //   if (currentUser.isUser) {
  //     user = await uploadUserPhoto(params);
  //   } else {
  //     print('object' * 100);
  //     user = await uploadProviderPhoto(params);
  //   }

  //   user.fold(
  //     (l) => emit(UserCubitStateError(l)),
  //     (r) {
  //       currentUser = r;

  //       emit(UserCubitStateLoaded(r));
  //     },
  //   );
  // }
}
///Users/hesham/FlutterDev/chefaa 2/android/app/build.gradle