import 'package:chefaa/core/api_errors/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/get_near.dart';

abstract class GetPharmacyByUserState extends Equatable {}

class GetPharmacyByUserStateIntial extends GetPharmacyByUserState {
  @override
  List<Object?> get props => [];
}

class GetPharmacyByUserStateLoading extends GetPharmacyByUserState {
  @override
  List<Object?> get props => [];
}

class GetPharmacyByUserStateLoaded extends GetPharmacyByUserState {
  final User user;

  GetPharmacyByUserStateLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class GetPharmacyByUserStateError extends GetPharmacyByUserState {
  final NetworkExceptions error;

  GetPharmacyByUserStateError(this.error);
  @override
  List<Object?> get props => [error];
}

class GetPharmacyByUserStateErrorFirstTime extends GetPharmacyByUserState {
  final NetworkExceptions error;

  GetPharmacyByUserStateErrorFirstTime(this.error);
  @override
  List<Object?> get props => [error];
}

class GetPharmacyByUserCubit extends Cubit<GetPharmacyByUserState> {
  GetPharmacyByUserCubit(
      this.getPharmacyByUserU, this.followPharmacyU, this.unFollowPharmacyU)
      : super(GetPharmacyByUserStateIntial());
  final GetPharmacyByUser getPharmacyByUserU;
  final FollowPharmacy followPharmacyU;
  final UnFollowPharmacy unFollowPharmacyU;

  /// Get Pharmacy By User and details
  Future<void> getPharmacyByUser(String id) async {
    emit(GetPharmacyByUserStateLoading());
    final result = await getPharmacyByUserU(id);
    result.fold((l) => emit(GetPharmacyByUserStateError(l)),
        (r) => emit(GetPharmacyByUserStateLoaded(r)));
    ;
  }

  /// Follow
  Future<void> followPharmacy(String id) async {
    final prev = state;
    emit(GetPharmacyByUserStateLoading());
    final result = await followPharmacyU(id);
    result.fold((l) {
      // GetPharmacyByUserStateErrorFirstTime
      if (prev is GetPharmacyByUserStateIntial) {
        emit(GetPharmacyByUserStateErrorFirstTime(l));
      }
      emit(GetPharmacyByUserStateError(l));
    }, (r) => emit(GetPharmacyByUserStateLoaded(r)));
    ;
  }

  /// UnFollow
  Future<void> unfollowPharmacy(String id) async {
    emit(GetPharmacyByUserStateLoading());
    final result = await unFollowPharmacyU(id);
    result.fold((l) => emit(GetPharmacyByUserStateError(l)),
        (r) => emit(GetPharmacyByUserStateLoaded(r)));
    ;
  }
}
