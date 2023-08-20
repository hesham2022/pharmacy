import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chefaa/Layout/pharamcy_layout/pharmacy_layout.dart';
import 'package:chefaa/Shared/bloc_observer.dart';
import 'package:chefaa/Shared/components/components.dart';
import 'package:chefaa/Shared/theme/cubit/theme_cubit.dart';
import 'package:chefaa/core/api_config/api_constants.dart';
import 'package:chefaa/core/utils/fcm_utils.dart';
import 'package:chefaa/layout/user_layout/user_layout.dart';
import 'package:chefaa/modeules/User/auth/presentation/blocs/change_phone_number_cubit/change_phone_number_cubit.dart';
import 'package:chefaa/modeules/User/auth/presentation/blocs/verify_otp%20_firebase/verify_otp_fiebase_cubit.dart';
import 'package:chefaa/modeules/User/auth/presentation/usr_bloc/user_cubit.dart';
import 'package:chefaa/translations/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'Shared/Themes.dart';
import 'core/local_storage/secure_storage_instance.dart';
import 'core/utils/hive_helper.dart';
import 'core/utils/pharmacy_notification_cubit.dart';
import 'di/get_it.dart';
import 'modeules/Descion_Screen/descion_screen.dart';
import 'modeules/User/Messages_Screen/chat_cubit.dart';
import 'modeules/User/Messages_Screen/chat_mode.dart';
import 'modeules/User/auth/domain/repositories/i_repository.dart';
import 'modeules/User/auth/presentation/blocs/auth_bloc/authentication_bloc.dart';
import 'modeules/User/auth/presentation/blocs/forget_password_bloc/forget_password_cubit.dart';
import 'modeules/User/auth/presentation/blocs/verify_otp/verify_otp_cubit.dart';
import 'modeules/User/auth/presentation/usr_bloc/get_near_cubit.dart';
import 'modeules/onBoarding_screen/onBoarding_screen.dart';
import 'modeules/onBoarding_screen/splach_screen.dart';

final notificationsBudgeCubit = NotificationsBudgeCubit();

bool? seenOnboard;
bool darkMode = false;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage event) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  await Firebase.initializeApp();
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: 'basic_tests',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
      )
    ],
  );
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: event.hashCode,
      channelKey: 'basic_channel',
      title: event.notification!.title ?? '',
      body: event.notification!.body,
    ),
  );
  await HiveService().init();
}

void main() async {
  WidgetsFlutterBinding();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await AwesomeNotifications().initialize(
    'resource://mipmap/launcher_icon',
    [
      NotificationChannel(
        channelGroupKey: 'basic_tests',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
      )
    ],
  );
  await EasyLocalization.ensureInitialized();
  await init();
  Bloc.observer = MyBlocObserver();
  await HiveService().init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider<AuthenticationBloc>(
          create: (context) => getIt<AuthenticationBloc>(),
        ),
        BlocProvider<UserCubit>(create: (_) => getIt<UserCubit>()),
        BlocProvider<ForgetPasswordCubit>(create: (ctx) => getIt()),
        BlocProvider<ChangephoneCubit>(create: (ctx) => getIt()),
        BlocProvider<GetNearCubit>(create: (ctx) => getIt()),
        BlocProvider<GetTopNearCubit>(create: (ctx) => getIt()),
        BlocProvider<GetNearWith24Cubit>(create: (ctx) => getIt()),
        BlocProvider<PharmacyNotificationsCubit>(
            create: (ctx) => PharmacyNotificationsCubit()),
        BlocProvider<UserNotificationsCubit>(
            create: (ctx) => UserNotificationsCubit()),
        BlocProvider<VerifyOtpFirebaseCubit>(
          create: (ctx) => getIt(),
        ),
        BlocProvider<VerifyOtpCubit>(
          create: (_) => getIt(),
        ),
        BlocProvider<NotificationsBudgeCubit>.value(
          value: notificationsBudgeCubit,
        ),
      ],
      child: EasyLocalization(
          supportedLocales: [Locale('en'), Locale('ar')],
          path:
              'assets/translations', // <-- change the path of the translation files
          fallbackLocale: Locale('en'),
          assetLoader: CodegenLoader(),
          child: MyApp()),
    ),
  );
}

bool _iconBool = false;
Socket socket = io(
  domain,
  OptionBuilder()
      .setTransports(['websocket']) // for Flutter or Dart VM
      .disableAutoConnect() // disable auto-connection
      .setExtraHeaders(<String, String>{'foo': 'bar'}) // optional
      .build(),
);

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final chatCubit = ChatCubit();

  // This widget is the root of your application.
  @override
  void initState() {
    socket
      ..connect()
      ..on('getMessage', (dynamic data) {
        final _message = Messages.fromJson(
          data,
        );

        chatCubit..addMessage(_message);
      })
      ..onAny((event, dynamic data) {
        print(event);
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);
    return (RepositoryProvider<Socket>(
      create: (context) => socket,
      child: BlocProvider<ChatCubit>.value(
        value: chatCubit,
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: SplashScreen(),
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) async {
                // ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text(state.status.toString())));
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    context.read<UserCubit>().addNewUser(state.user);

                    print(state.user.id);
                    // context.read<UserCubit>().addNewUser(state.user);
                    // await PushNotifications()
                    //     .init(context, notificationsBudgeCubit);
                    if (state.user.role == 'user' ||
                        state.user.role == 'admin') {
                      socket.emit('addUser',
                          {'userId': state.user.id, 'userType': 'user'});
                      // await navigation.navigateToAndClearStack(
                      //     null, RoutesName.userHome);
                      // navigateAndFinish(context, UserHomeScreen());
                      _navigatorKey.currentState!.pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => UserLayout(),
                        ),
                        (route) {
                          return false;
                        },
                      );
                      await PushNotifications()
                          .init(context, notificationsBudgeCubit, state.user);
                      // if (!state.user.isOtpVerified) {
                      //   await _appRouter.pushAndPopUntil(
                      //     const OtpFirebasePagePageRoute(),
                      //     predicate: (d) => false,
                      //   );
                      // } else {
                      //   await _appRouter.pushAndPopUntil(
                      //     const MainScaffold(),
                      //     predicate: (d) => false,
                      //   );
                      // }
                    } else {
                      socket.emit('addUser',
                          {'userId': state.user.id, 'userType': 'pharmacy'});
                      await PushNotifications()
                          .init(context, notificationsBudgeCubit, state.user);
                      _navigatorKey.currentState!.pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => PharmacyLayout(),
                        ),
                        (route) {
                          return false;
                        },
                      );
                      // await _appRouter.pushAndPopUntil(
                      //   const MainProviderRouter(),
                      //   predicate: (d) => false,
                      // );
                    }
                    await Storage.setIsFirst();
                    break;
                  case AuthenticationStatus.unauthenticated:
                    final isFirst = await Storage.isFirst();
                    if (isFirst) {
                      _navigatorKey.currentState!.pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => OnBoardingScreen()),
                          (e) => false);
                    }
                    _navigatorKey.currentState!.pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => DescionScreen()),
                        (e) => false);
                    await Storage.setIsFirst();
                    break;
                  case AuthenticationStatus.unknown:
                    _navigatorKey.currentState!.pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => SplashScreen()),
                        (e) => false);
                    await Storage.setIsFirst();
                    break;
                  case AuthenticationStatus.signUpSucess:
                    print('*' * 1000);
                    // await navigation.navigateToAndClearStack(
                    //     null, RoutesName.userHome);
                    navigateAndFinish(context, UserLayout());

                    await Storage.setIsFirst();
                    break;
                }
              },
              child: child!,
            );
          },
          theme: theme.isDark ? darkTheme : lightTheme,
          debugShowCheckedModeBanner: false,
        ),
      ),
    ));
  }
}
