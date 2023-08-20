import 'dart:async';
import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chefaa/core/utils/hive_helper.dart';
import 'package:chefaa/core/utils/pharmacy_notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../modeules/User/auth/domain/entities/update_user_params.dart';
import '../../modeules/User/auth/domain/entities/user.dart';
import '../../modeules/User/auth/presentation/usr_bloc/user_cubit.dart';

class NotificationsBudgeCubit extends Cubit<int> {
  NotificationsBudgeCubit() : super(0);
  void newNotifion() => emit(state + 1);
  void read() => emit(0);
}

class PushNotifications {
  factory PushNotifications() => _instance;
  PushNotifications._internal();

  static String? fcmToken;
  static final PushNotifications _instance = PushNotifications._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initToken() async {
    debugPrint('===== Begin =====');

    await _firebaseMessaging.requestPermission();
    await _firebaseMessaging.getToken().then((token) {
      debugPrint('===== FCM Token =====');
      debugPrint(token);
      fcmToken = token;
    });
  }

  Future<void> init(
      BuildContext context, NotificationsBudgeCubit bloc, User user) async {
    await _firebaseMessaging.requestPermission();

    // Get device token
    await _firebaseMessaging.getToken().then((token) {
      debugPrint('===== FCM Token =====');

      debugPrint(token);
      fcmToken = token;

      context.read<UserCubit>().updateUserFunc(
            UpdateUserParams(fcm: fcmToken),
          );
    });
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      bloc.newNotifion();
    }
    // _firebaseMessaging.subscribeToTopic('64100aa2fd1ce91a13a670d4');
    FirebaseMessaging.onMessage.listen(
      (event) async {
        debugPrint('===== New Notification =====');
        debugPrint(event.notification!.toString());
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: event.hashCode,
            channelKey: 'basic_channel',
            title: event.notification!.title ?? '',
            body: event.notification!.body,
          ),
        );
        bloc.newNotifion();
        // if (event.data['appointment'] != null) {
        //   final appointment = AppointmentModel.fromJson(
        //     event.data['appointment'] as String,
        //   );
        //   final notificationModel = NotificationsModel(
        //     title: event.notification!.title!,
        //     sentTime: event.sentTime!,
        //     appointment: appointment,
        //   );
        //   context.read<NotificationsCubit>().add(notificationModel);

        //   context
        //       .read<MyAppointmentsCubit>()
        //       .addFromFcm(notificationModel.appointment);

        //   } else {
        //     await HiveService.userBox().put(
        //       event.messageId,
        //       notificationModel.toMap(),
        //     );
        //   }
        // }
        final data = jsonDecode(event.data['data']);

        if (data['to'] == 'pharmacy') {
          print('@' * 300);
          print(data['to']);
          await Hive.box<Map<dynamic, dynamic>>(
            HiveService.providerNotificationBox,
          ).put(
            event.messageId,
            PharmacyNoitifcationModel(
                    title: event.notification!.title!,
                    body: event.notification!.body!,
                    date: event.sentTime,
                    id: null,
                    post: data['post'],
                    user: data['user'])
                .toMap(),
          );
        } else {
          await Hive.box<Map<dynamic, dynamic>>(
            HiveService.userrNotificationBox,
          ).put(
            event.messageId,
            PharmacyNoitifcationModel(
                    title: event.notification!.title!,
                    body: event.notification!.body!,
                    date: event.sentTime,
                    id: null,
                    post: data['post'],
                    user: data['user'])
                .toMap(),
          );
        }

        // if (event.data['to'] == 'pharmacy') {
        //   print('______________');
        //   await Hive.box<Map<dynamic, dynamic>>(
        //     HiveService.providerNotificationBox,
        //   ).put(
        //     event.messageId,
        //     PharmacyNoitifcationModel.fromMap(event.data).toMap(),
        //   );
        // }
      },
    );

    _firebaseMessaging.onTokenRefresh.listen((event) {
      fcmToken = event;
      context.read<UserCubit>().updateUserFunc(
            UpdateUserParams(fcm: fcmToken),
          );
    });
    // Configure messaging receiving
  }
}
