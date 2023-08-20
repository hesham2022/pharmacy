import 'package:carousel_slider/carousel_slider.dart';
import 'package:chefaa/Shared/components/components.dart';
import 'package:chefaa/core/api_config/api_constants.dart';
import 'package:chefaa/core/utils/map_utils/location_service.dart';
import 'package:chefaa/modeules/User/Home_Screen/search_screen.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/get_near_params.dart';
import 'package:chefaa/modeules/User/auth/presentation/usr_bloc/get_near_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Shared/icons.dart';
import '../../../Shared/theme/cubit/theme_cubit.dart';
import '../../view_stores/store_details.dart';
import '../../view_stores/stores_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  void initState() {
    context.read<GetNearCubit>().getProviderFunc(GetNearParams(
        lat: LocationService.position!.latitude,
        lon: LocationService.position!.longitude,
        queryParams: {}));
    context.read<GetTopNearCubit>().getProviderFunc(GetNearParams(
        lat: LocationService.position!.latitude,
        lon: LocationService.position!.longitude,
        queryParams: {}));
    context.read<GetNearWith24Cubit>().getProviderFunc(GetNearParams(
        lat: LocationService.position!.latitude,
        lon: LocationService.position!.longitude,
        queryParams: {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, ThemeState>(
      listener: (context, state) {},
      builder: (context, state) {
        ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
        return Scaffold(
          backgroundColor: theme.isDark ? Color(0xff303030) : Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(
                          readOnly: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SearchPharmaciesPage()));
                          },
                          decoration: InputDecoration(
                              filled: true,
                              hintStyle: TextStyle(
                                  color: theme.isDark
                                      ? Colors.white
                                      : Colors.grey[500]),
                              fillColor: theme.isDark
                                  ? Color.fromARGB(255, 23, 23, 23)
                                  : Colors.grey[200],
                              hintText: 'lookFor'.tr(),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none),
                              prefixIcon: Icon(
                                IconBroken.Search,
                                color: Colors.grey,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      reverse: false,
                      aspectRatio: 3,
                      enlargeCenterPage: true,
                    ),
                    items: imageSliders,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'closestTo'.tr(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: theme.isDark
                                ? Color.fromARGB(255, 255, 255, 255)
                                : Colors.black),
                      ),
                      TextButton(
                          onPressed: () {
                            navigateTo(context, StoresScreen());
                          },
                          child: Text(
                            'viewAll'.tr(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff089BAB)),
                          ))
                    ],
                  ),
                ),
                BlocBuilder<GetNearCubit, GetNearCubitState>(
                  builder: (context, state) {
                    if (state is GetNearCubitStateLoaded)
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children:
                                List.generate(state.users.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              navigateTo(
                                  context,
                                  StoreDetails(
                                    pharmacyId: state.users[index].id,
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 200,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: NetworkImage(getPhotoLink(
                                            state.users[index].mainPhoto!)),
                                        fit: BoxFit.cover)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          color: Color(0xff089BAB),
                                          child: Row(
                                            children: [
                                              Text(
                                                '${state.users[index].distance! ~/ 1000} كم',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Icon(
                                                Icons.location_pin,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                        width: 200,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            color: theme.isDark
                                                ? Color(0xff089bab)
                                                : Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state
                                                    .users[index].pharmacyName!,
                                                style: TextStyle(
                                                    color: theme.isDark
                                                        ? Color.fromARGB(
                                                            255, 255, 255, 255)
                                                        : Color.fromARGB(
                                                            255, 0, 0, 0)),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                state.users[index].address!
                                                        .governorate +
                                                    '/' +
                                                    state.users[index].address!
                                                        .region,
                                                style: TextStyle(
                                                    color: theme.isDark
                                                        ? Color.fromARGB(
                                                            255, 255, 255, 255)
                                                        : Colors.grey),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
                      );
                    if (state is GetNearCubitStateLoading)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    if (state is GetNearCubitStateError)
                      return Center(
                        child: Text(state.error.errorMessege),
                      );
                    return SizedBox();
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'work24'.tr(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: theme.isDark
                                ? Color.fromARGB(255, 255, 255, 255)
                                : Colors.black),
                      ),
                      TextButton(
                          onPressed: () {
                            navigateTo(context, StoresScreen());
                          },
                          child: Text(
                            'viewAll'.tr(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff089BAB)),
                          ))
                    ],
                  ),
                ),
                Working24Widget(),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'topRated'.tr(),
                        style: TextStyle(
                            fontSize: 18,
                            color: theme.isDark
                                ? Color.fromARGB(255, 255, 255, 255)
                                : Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                          onPressed: () {
                            navigateTo(context, StoresScreen());
                          },
                          child: Text(
                            'viewAll'.tr(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff089BAB)),
                          ))
                    ],
                  ),
                ),
                TopWidget()
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //       children: List.generate(data.length, (index) {
                //     return Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Container(
                //         width: 200,
                //         height: 210,
                //         decoration: BoxDecoration(
                //             color: Colors.blue,
                //             borderRadius: BorderRadius.circular(5),
                //             image: DecorationImage(
                //                 image: NetworkImage(data[index]['img']),
                //                 fit: BoxFit.cover)),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             Row(
                //               children: [
                //                 Container(
                //                   color: Colors.white,
                //                   child: Row(
                //                     children: [
                //                       Text(
                //                         '4.5 كم',
                //                         style:
                //                             TextStyle(color: Color(0xff089BAB)),
                //                       ),
                //                       Icon(
                //                         Icons.location_pin,
                //                         color: Color(0xff089BAB),
                //                       )
                //                     ],
                //                   ),
                //                 )
                //               ],
                //             ),
                //             Container(
                //                 width: 200,
                //                 height: 70,
                //                 decoration: BoxDecoration(
                //                   color: Color(0xff089BAB),
                //                 ),
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.start,
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       Row(
                //                         children: [
                //                           Text(
                //                             data[index]['name'],
                //                             style:
                //                                 TextStyle(color: Colors.white),
                //                           ),
                //                           Icon(
                //                             Icons.star,
                //                             color: Color(0xfff6b921),
                //                             size: 20,
                //                           ),
                //                           Text(
                //                             data[index]['rate'],
                //                             style: TextStyle(
                //                                 color: Colors.white,
                //                                 fontSize: 13),
                //                           ),
                //                         ],
                //                       ),
                //                       SizedBox(
                //                         height: 5,
                //                       ),
                //                       Text(
                //                         data[index]['desc'],
                //                         style: TextStyle(color: Colors.white),
                //                         maxLines: 1,
                //                         overflow: TextOverflow.ellipsis,
                //                       )
                //                     ],
                //                   ),
                //                 ))
                //           ],
                //         ),
                //       ),
                //     );
                //   })),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Working24Widget extends StatelessWidget {
  const Working24Widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNearWith24Cubit, GetNearCubitState>(
      builder: (context, state) {
        if (state is GetNearCubitStateLoaded)
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(state.users.length, (index) {
              final user = state.users[index];
              return GestureDetector(
                onTap: () {
                  navigateTo(
                      context,
                      StoreDetails(
                        pharmacyId: state.users[index].id,
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: NetworkImage(getPhotoLink(user.mainPhoto!)),
                            fit: BoxFit.cover)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Text(
                                    '${user.distance! ~/ 1000} كم',
                                    style: TextStyle(color: Color(0xff089BAB)),
                                  ),
                                  Icon(
                                    Icons.location_pin,
                                    color: Color(0xff089BAB),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                            width: 200,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xff089BAB),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        user.pharmacyName!,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Color(0xfff6b921),
                                        size: 20,
                                      ),
                                      Text(
                                        user.ratingsAverage!.toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    state.users[index].address!.governorate +
                                        '/' +
                                        state.users[index].address!.region,
                                    style: TextStyle(color: Colors.white),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              );
            })),
          );
        if (state is GetNearCubitStateLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (state is GetNearCubitStateError)
          return Center(
            child: Text(state.error.errorMessege),
          );
        return SizedBox();
      },
    );
  }
}

class TopWidget extends StatelessWidget {
  const TopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTopNearCubit, GetNearCubitState>(
      builder: (context, state) {
        if (state is GetNearCubitStateLoaded)
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(state.users.length, (index) {
              final user = state.users[index];
              return GestureDetector(
                onTap: () {
                  navigateTo(
                      context,
                      StoreDetails(
                        pharmacyId: state.users[index].id,
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: NetworkImage(getPhotoLink(user.mainPhoto!)),
                            fit: BoxFit.cover)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Text(
                                    '${user.distance! ~/ 1000} كم',
                                    style: TextStyle(color: Color(0xff089BAB)),
                                  ),
                                  Icon(
                                    Icons.location_pin,
                                    color: Color(0xff089BAB),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                            width: 200,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xff089BAB),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        user.pharmacyName!,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Color(0xfff6b921),
                                        size: 20,
                                      ),
                                      Text(
                                        user.ratingsAverage!.toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    state.users[index].address!.governorate +
                                        '/' +
                                        state.users[index].address!.region,
                                    style: TextStyle(color: Colors.white),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              );
            })),
          );
        if (state is GetNearCubitStateLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (state is GetNearCubitStateError)
          return Center(
            child: Text(state.error.errorMessege),
          );
        return SizedBox();
      },
    );
  }
}

final List<String> imgList = [
  'assets/images/1.png',
  'assets/images/2.jpg',
  'assets/images/3.jpg',
  'assets/images/4.jpg',
  'assets/images/5.jpg',
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          decoration: BoxDecoration(
              color: Color(0xff8790ee),
              borderRadius: BorderRadius.circular(10)),
          child: Container(
            child: Stack(
              children: <Widget>[
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 20, right: 20),
                          child: Column(
                            children: [
                              Container(
                                width: 150,
                                child: Text('Discount'.tr(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text(
                                    "shop now",
                                    style: TextStyle(color: Color(0xff089BAB)),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.asset(item,
                                fit: BoxFit.cover, width: 100.0)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ))
    .toList();
