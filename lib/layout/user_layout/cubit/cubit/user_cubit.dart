import 'package:chefaa/Layout/user_layout/cubit/states/user_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../modeules/User/Home_Screen/home_screen.dart';
import '../../../../modeules/User/Map_Screen/map_screen.dart';
import '../../../../modeules/User/Messages_Screen/messages_screen.dart';
import '../../../../modeules/User/Notification_Screen/notifications_screen.dart';

class UserLayoutCubit extends Cubit<UserStates> {
  UserLayoutCubit() : super(UserInitialState());

  static UserLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    UserHomeScreen(),
    UserMapScreen(),
    UserMessagesScreen(),
    UserNotificationsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(UserChangeBottomNavState());
  }
}
