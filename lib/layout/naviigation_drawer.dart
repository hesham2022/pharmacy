import 'package:chefaa/Layout/drawer_item.dart';
import 'package:chefaa/Layout/pharamcy_layout/cubit.dart';
import 'package:chefaa/Layout/pharamcy_layout/pharmacy_layout.dart';
import 'package:chefaa/Shared/icons.dart';
import 'package:chefaa/Shared/theme/cubit/theme_cubit.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

bool _darkMode = false;

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
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

             ListTile(
               title: Text('lang'.tr(),style: TextStyle(color: Colors.white,fontSize: 15),),
               leading: Icon(Icons.language,color: Colors.white,),
               trailing: IconButton(
                 onPressed: (){
                   showDialog(
                       context: context,
                       builder: (context)=>
                           AlertDialog(
                         actions: [
                           IconButton(
                             onPressed: () {
                               setState(() {
                                 context.setLocale(Locale('ar'));
                               });
                             },
                             icon: Text("AR"),),
                           SizedBox(width: 10,),
                           IconButton(
                             onPressed: () {
                               setState(() {
                                 context.setLocale(Locale('en'));
                               });
                             },
                             icon: Text("En"),),
                         ],
                       )
                   );
                 },
                 icon: Icon(IconBroken.Arrow___Right,color: Colors.white,),
               )
             ),
             ListTile(
               title: Text('mode'.tr(),style: TextStyle(color: Colors.white,fontSize: 15),),
               leading: Icon(Icons.dark_mode,color: Colors.white,),
               trailing: Switch(
                 value: _darkMode,
                 onChanged: (value)
                 {
                   setState(() {
                     _darkMode=false;
                     theme.changeTheme();
                   });
                 },
               )
             ),
             ListTile(
               title: Text('share'.tr(),style: TextStyle(color: Colors.white),),
               leading: Icon(Icons.share,color: Colors.white,),

             ),


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
                  onPressed: () => onItemPressed(context, index: 5)),
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
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(url),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Mohamed Atef',
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
  }
}
