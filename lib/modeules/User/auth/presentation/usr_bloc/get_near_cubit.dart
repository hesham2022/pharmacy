import 'package:chefaa/modeules/User/auth/domain/entities/get_near_params.dart';
import 'package:chefaa/modeules/User/auth/domain/usecases/get_near.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/api_errors/network_exceptions.dart';
import '../../domain/entities/user.dart';

abstract class GetNearCubitState extends Equatable {}

class GetNearCubitStateInitil extends GetNearCubitState {
  @override
  List<Object?> get props => [];
}

class GetNearCubitStateLoading extends GetNearCubitState {
  @override
  List<Object?> get props => [];
}

class GetNearCubitStateError extends GetNearCubitState {
  GetNearCubitStateError(this.error);
  final NetworkExceptions error;
  @override
  List<Object?> get props => [];
}

class GetNearCubitStateLoaded extends GetNearCubitState {
  GetNearCubitStateLoaded(this.users);
  final List<User> users;

  @override
  List<Object?> get props => [users];
}

class GetNearCubit extends Cubit<GetNearCubitState> {
  GetNearCubit({
    required this.getNearU,
  }) : super(GetNearCubitStateInitil());
  final GetNearU getNearU;
  Future<void> getProviderFunc(GetNearParams params) async {
    emit(GetNearCubitStateLoading());
    final result = await getNearU(params);
    result.fold(
      (l) => emit(GetNearCubitStateError(l)),
      (r) {
        emit(GetNearCubitStateLoaded(r));
      },
    );
  }
}
class GetTopNearCubit extends Cubit<GetNearCubitState> {
  GetTopNearCubit({
    required this.getNearU,
  }) : super(GetNearCubitStateInitil());
  final GetTopNearU getNearU;
  Future<void> getProviderFunc(GetNearParams params) async {
    emit(GetNearCubitStateLoading());
    final result = await getNearU(params);
    result.fold(
      (l) => emit(GetNearCubitStateError(l)),
      (r) {
        emit(GetNearCubitStateLoaded(r));
      },
    );
  }
}
class GetNearWith24Cubit extends Cubit<GetNearCubitState> {
  GetNearWith24Cubit({
    required this.getNearU,
  }) : super(GetNearCubitStateInitil());
  final GetNearWith24U getNearU;
  Future<void> getProviderFunc(GetNearParams params) async {
    emit(GetNearCubitStateLoading());
    final result = await getNearU(params);
    result.fold(
      (l) => emit(GetNearCubitStateError(l)),
      (r) {
        emit(GetNearCubitStateLoaded(r));
      },
    );
  }
}
