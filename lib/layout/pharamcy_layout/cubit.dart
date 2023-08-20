import 'package:chefaa/Layout/pharamcy_layout/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modeules/Pharmacy/Add_Post/add_screen.dart';
import '../../modeules/Pharmacy/AdminScreen/admin_screen.dart';
import '../../modeules/Pharmacy/Messages_Screen/messages_screen.dart';
import '../../modeules/Pharmacy/Notification_Screen/notifications_screen.dart';
import '../../modeules/User/Home_Screen/home_screen.dart';

class PharmacyCubit extends Cubit<PharmacyStates> {
  PharmacyCubit() : super(PharmacyInitialState());

  static PharmacyCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    // PharmacyHomeScreen(),
    UserHomeScreen(),
    AdminScreen(),
    AddPostScreen(),
    PharmacyMessagesScreen(),
    PharmacyNotificationsScreen(),
  ];

  void changeBottom(int index) {
    if (index == 2)
      emit(PharmacyAddPostState());
    else {
      emit(PharmacyChangeBottomNavState());
      currentIndex = index;
    }
  }
}
