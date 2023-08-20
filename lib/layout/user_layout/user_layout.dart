import 'package:chefaa/Layout/user_layout/cubit/states/user_states.dart';
import 'package:chefaa/Shared/icons.dart';
import 'package:chefaa/Shared/theme/cubit/theme_cubit.dart';
import 'package:chefaa/core/api_config/index.dart';
import 'package:chefaa/core/utils/fcm_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../modeules/User/auth/presentation/blocs/auth_bloc/authentication_bloc.dart';
import '../pharamcy_layout/nav_drawer.dart';
import 'cubit/cubit/user_cubit.dart';

class UserLayout extends StatefulWidget {
  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
    return BlocProvider(
      create: (BuildContext context) => UserLayoutCubit(),
      child: BlocConsumer<UserLayoutCubit, UserStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = UserLayoutCubit.get(context);
          return Scaffold(
            backgroundColor: theme.isDark ? Color(0xff303030) : Colors.white,
            drawer: NavDrawer(),
            appBar: AppBar(
              backgroundColor: theme.isDark ? Color(0xff303030) : Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Saydlety',
                style: TextStyle(color: Color(0xff089BAB)),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.qr_code_2,
                    color: Color(0xff089BAB),
                  ),
                  onPressed: () {},
                ),
              ],
              leading: context
                          .read<AuthenticationBloc>()
                          .state
                          .user
                          .mainPhoto ==
                      null
                  ? null
                  : Builder(builder: (context) {
                      return IconButton(
                        icon: CircleAvatar(
                            backgroundImage: NetworkImage(getPhotoLink(context
                                .read<AuthenticationBloc>()
                                .state
                                .user
                                .mainPhoto!))),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    }),
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Color(0xff089BAB),
              unselectedItemColor: Color(0x9b8c8c8c),
              onTap: (index) {
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.home),
                  label: 'Home'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location),
                  label: 'map'.tr(),
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
