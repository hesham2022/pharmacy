import 'package:chefaa/modeules/Pharmacy/Notification_Screen/notifications_screen.dart';
import 'package:chefaa/modeules/view_stores/post_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../Shared/components/components.dart';
import '../../../Shared/theme/cubit/theme_cubit.dart';
import '../../../core/utils/pharmacy_notification_cubit.dart';

class UserNotificationsScreen extends StatefulWidget {
  const UserNotificationsScreen({Key? key}) : super(key: key);

  @override
  State<UserNotificationsScreen> createState() =>
      _UserNotificationsScreenState();
}

class _UserNotificationsScreenState extends State<UserNotificationsScreen> {
  @override
  void initState() {
    context.read<UserNotificationsCubit>().getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);

    return Scaffold(
        body: BlocBuilder<UserNotificationsCubit, PharmacyNotificationsState>(
      builder: (context, state) {
        if (state is PharmacyNotificationsLoaded) {
          final n = state.notifications;
          return SingleChildScrollView(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                      color: theme.isDark
                          ? Color.fromARGB(255, 24, 24, 24)
                          : Colors.white,
                      elevation: 1.0,
                      child: ListTile(
                        onTap: () {
                          navigateTo(
                              context,
                              PostDetails(
                                id: n[index].post!,
                              ));
                        },
                        leading: Container(
                            width: 30,
                            height: 50,
                            child: Lottie.asset('assets/lottie/bell.json')),
                        title: Text(
                          n[index].title ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: theme.isDark
                                ? Color.fromARGB(255, 255, 255, 255)
                                : Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          n[index].body ?? '',
                          maxLines: 1,
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        trailing: Text(getAgo(n[index].date!)),
                      )
                      // Padding(
                      //   padding: const EdgeInsets.all(5.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       Container(
                      //         width: 30,
                      //         height: 50,
                      //         child: Lottie.asset('assets/lottie/bell.json'),
                      //       ),
                      //       SizedBox(
                      //         width: 150,
                      //         child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               const SizedBox(
                      //                 height: 5.0,
                      //               ),
                      //               Text(
                      //                 n[index].title ?? '',
                      //                 overflow: TextOverflow.ellipsis,
                      //                 maxLines: 1,
                      //                 style: TextStyle(
                      //                   color: theme.isDark
                      //                       ? Color.fromARGB(255, 255, 255, 255)
                      //                       : Colors.black,
                      //                 ),
                      //               ),
                      //               SizedBox(
                      //                 height: 10,
                      //               ),
                      //               Text(
                      //                 n[index].body ?? '',
                      //                 maxLines: 1,
                      //                 // overflow: TextOverflow.ellipsis,
                      //                 style: TextStyle(
                      //                     fontSize: 13, color: Colors.grey),
                      //               ),
                      //             ]),
                      //       ),
                      //       Column(
                      //         children: [
                      //           Row(
                      //             children: [
                      //               Container(
                      //                 color: theme.isDark
                      //                     ? Color.fromARGB(255, 24, 24, 24)
                      //                     : Color.fromARGB(255, 255, 255, 255),
                      //                 child: Row(
                      //                   children: [
                      //                     Text(
                      //                       getAgo(n[index].date!),
                      //                       style: TextStyle(
                      //                           color: theme.isDark
                      //                               ? Color.fromARGB(
                      //                                   255, 255, 255, 255)
                      //                               : Color.fromARGB(
                      //                                   255, 0, 0, 0),
                      //                           fontSize: 13),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      ),
                );
              },
              itemCount: n.length,
            ),
          );
        }
        return SizedBox();
      },
    ));
  }
}
