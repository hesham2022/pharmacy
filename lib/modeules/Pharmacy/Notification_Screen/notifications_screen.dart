import 'package:chefaa/Shared/theme/cubit/theme_cubit.dart';
import 'package:chefaa/core/utils/hive_helper.dart';
import 'package:chefaa/modeules/User/auth/presentation/blocs/auth_bloc/authentication_bloc.dart';
import 'package:chefaa/modeules/view_stores/post_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../Shared/components/components.dart';
import '../../../core/utils/pharmacy_notification_cubit.dart';
import '../../view_stores/store_details.dart';

String getAgo(DateTime date) {
  final duration = DateTime.now().difference(date);
  if (duration.inDays > 0) {
    return '${duration.inDays} day';
  }
  if (duration.inHours > 0) {
    return '${duration.inHours} hours';
  }
  if (duration.inMinutes > 0) {
    return '${duration.inMinutes} minutes';
  }
  return 'now';
}

class PharmacyNotificationsScreen extends StatefulWidget {
  const PharmacyNotificationsScreen({Key? key}) : super(key: key);

  @override
  State<PharmacyNotificationsScreen> createState() =>
      _PharmacyNotificationsScreenState();
}

class _PharmacyNotificationsScreenState
    extends State<PharmacyNotificationsScreen> {
  @override
  void initState() {
    context.read<PharmacyNotificationsCubit>().getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
    print(HiveService.providerBox().toMap());
    return Scaffold(body:
        BlocBuilder<PharmacyNotificationsCubit, PharmacyNotificationsState>(
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
                          if (n[index].post != null) {
                            navigateTo(
                                context, PostDetails(id: n[index].post!));
                          }
                          navigateTo(
                              context,
                              StoreDetails(
                                pharmacyId: context
                                    .read<AuthenticationBloc>()
                                    .state
                                    .user
                                    .id,
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
