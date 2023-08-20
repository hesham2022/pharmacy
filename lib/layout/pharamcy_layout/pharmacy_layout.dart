import 'package:chefaa/Layout/pharamcy_layout/cubit.dart';
import 'package:chefaa/Layout/pharamcy_layout/states.dart';
import 'package:chefaa/Shared/components/components.dart';
import 'package:chefaa/core/api_config/api_constants.dart';
import 'package:chefaa/modeules/User/auth/presentation/blocs/auth_bloc/authentication_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Shared/icons.dart';
import '../../Shared/theme/cubit/theme_cubit.dart';
import '../../core/utils/fcm_utils.dart';
import '../../modeules/Pharmacy/Add_Post/add_screen.dart';
import 'nav_drawer.dart';

class PharmacyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
    return BlocProvider(
      create: (BuildContext context) => PharmacyCubit(),
      child: BlocConsumer<PharmacyCubit, PharmacyStates>(
        listener: (context, state) {
          if (state is PharmacyAddPostState) {
            navigateTo(context, AddPostScreen());
          }
        },
        builder: (context, state) {
          var cubit = PharmacyCubit.get(context);
          return Scaffold(
            drawer: NavDrawer(),
            appBar: AppBar(
              backgroundColor: theme.isDark ? Color(0xff303030) : Colors.white,
              elevation: 1,
              centerTitle: true,
              title: Text(
                'Sydlety',
                style: TextStyle(color: Color(0xff089BAB)),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    IconBroken.Scan,
                    color: Color(0xff089BAB),
                  ),
                  onPressed: () {},
                ),
              ],
              leading: Builder(builder: (context) {
                return IconButton(
                  icon: CircleAvatar(
                      backgroundImage: NetworkImage(
                    getPhotoLink(context
                        .read<AuthenticationBloc>()
                        .state
                        .user
                        .mainPhoto!),
                  )),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              }),
            ),
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? Color.fromARGB(255, 255, 255, 255)
                : Color(0xff303030),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Color(0xff089BAB),
              unselectedItemColor: Color(0x9b8c8c8c),
              onTap: (index) {
                cubit.changeBottom(index);
                if (index == 4) {
                  context.read<NotificationsBudgeCubit>().read();
                }
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.home),
                  label: "Home".tr(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chart),
                  label: "admin".tr(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload),
                  label: "add".tr(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Activity),
                  label: "inbox".tr(),
                ),
                BottomNavigationBarItem(
                  icon: BlocBuilder<NotificationsBudgeCubit, int>(
                    builder: (context, state) {
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(IconBroken.Notification),
                          Positioned(
                            top: -5,
                            right: -1,
                            child: Text(state == 0 ? '' : state.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          )
                        ],
                      );
                    },
                  ),
                  label: "notify".tr(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
