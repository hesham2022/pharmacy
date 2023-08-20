import 'package:chefaa/core/api_errors/index.dart';
import 'package:chefaa/core/utils/hive_helper.dart';
import 'package:chefaa/core/utils/pharmacy_notification_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class PharmacyNotificationsState extends Equatable {}

class PharmacyNotificationsInitial extends PharmacyNotificationsState {
  @override
  List<Object?> get props => [];
}

class PharmacyNotificationsLoading extends PharmacyNotificationsState {
  @override
  List<Object?> get props => [];
}

class PharmacyNotificationsLoaded extends PharmacyNotificationsState {
  final List<PharmacyNoitifcationModel> notifications;

  PharmacyNotificationsLoaded(this.notifications);
  @override
  List<Object?> get props => [notifications];
}

class PharmacyNotificationsError extends PharmacyNotificationsState {
  final NetworkExceptions error;

  PharmacyNotificationsError(this.error);
  @override
  List<Object?> get props => [error];
}

final s = HiveService.providerBox().listenable();

class PharmacyNotificationsCubit extends Cubit<PharmacyNotificationsState> {
  PharmacyNotificationsCubit() : super(PharmacyNotificationsInitial()) {
    s.addListener(() {
      getNotification();
    });
  }
  void getNotification() {
    emit(PharmacyNotificationsLoading());
    final data = HiveService.providerBox().values.map((e) {
      return PharmacyNoitifcationModel.fromMap(e);
    });
    emit(PharmacyNotificationsLoaded(data.toList().reversed.toList()));
  }
}

final s2 = HiveService.userBox().listenable();

class UserNotificationsCubit extends Cubit<PharmacyNotificationsState> {
  UserNotificationsCubit() : super(PharmacyNotificationsInitial()) {
    s2.addListener(() {
      getNotification();
    });
  }
  void getNotification() {
    emit(PharmacyNotificationsLoading());
    final data = HiveService.userBox().values.map((e) {
      return PharmacyNoitifcationModel.fromMap(e);
    });
    print(data);
    emit(PharmacyNotificationsLoaded(data.toList().reversed.toList()));
  }
}
