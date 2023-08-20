import 'package:chefaa/Layout/drawer_item.dart';
import 'package:chefaa/Layout/pharamcy_layout/pharmacy_layout.dart';
import 'package:chefaa/core/api_config/api_constants.dart';
import 'package:chefaa/modeules/User/auth/presentation/blocs/auth_bloc/authentication_bloc.dart';
import 'package:chefaa/modeules/User/auth/presentation/usr_bloc/user_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modeules/User/auth/presentation/usr_bloc/user_cubit_state.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color(0xff089BAB),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
          child: Column(
            children: [
              headerWidget(),
              const SizedBox(
                height: 40,
              ),
              const Divider(
                thickness: 1,
                height: 10,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 40,
              ),
              DrawerItem(
                name: 'Language',
                icon: Icons.translate,
                onPressed: () {
                  context.setLocale(Locale('en'));
                },
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerItem(
                  name: 'Dark Mode',
                  icon: Icons.dark_mode_outlined,
                  onPressed: () {}),
              const SizedBox(
                height: 30,
              ),
              DrawerItem(
                  name: 'Share this app',
                  icon: Icons.share,
                  onPressed: () => onItemPressed(context, index: 2)),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                thickness: 1,
                height: 10,
                color: Colors.white,
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerItem(
                  name: 'About us',
                  icon: Icons.info_outline,
                  onPressed: () => onItemPressed(context, index: 4)),
              const SizedBox(
                height: 30,
              ),
              DrawerItem(
                  name: 'Log out',
                  icon: Icons.logout,
                  onPressed: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogoutRequested());
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PharmacyLayout()));
        break;
    }
  }

  Widget headerWidget() {
    const url =
        'https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cGVyc29uJTIwYXZhdGFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60';
    return BlocBuilder<UserCubit, UserCubitState>(
      builder: (context, state) {
        print(state is UserCubitStateLoaded);
        if (state is UserCubitStateLoaded)
          return Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(getPhotoLink(
                        state.user.mainPhoto!) ??
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(state.user.name,
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                  SizedBox(
                    height: 10,
                  ),
                  Text('+201005743347',
                      style: TextStyle(fontSize: 14, color: Colors.white))
                ],
              )
            ],
          );
        return Text(state.toString());
      },
    );
  }
}
