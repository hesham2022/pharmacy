import 'package:carousel_slider/carousel_slider.dart';

import 'package:chefaa/Shared/components/components.dart';
import 'package:chefaa/Shared/icons.dart';
import 'package:chefaa/Shared/theme/cubit/theme_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../User/Home_Screen/data.dart';
import '../view_stores/stores_screen.dart';

class PharmacyHomeScreen extends StatefulWidget {
  const PharmacyHomeScreen({Key? key}) : super(key: key);

  @override
  State<PharmacyHomeScreen> createState() => _PharmacyHomeScreenState();
}

class _PharmacyHomeScreenState extends State<PharmacyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
    return BlocConsumer<ThemeCubit,ThemeState>(
      listener: (context, state) {
      },
      builder: (context,state){
        return Scaffold(
          backgroundColor: theme.isDark ? Color(0xff303030) : Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              filled: true,
                              hintStyle: TextStyle(color: theme.isDark ? Colors.white : Colors.grey[500]),
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
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,
                          color: theme.isDark
                              ? Color.fromARGB(255, 255, 255, 255)
                              : Colors.black
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            navigateTo(context, PharmacyStoresScreen());
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(data.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 200,
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage(data[index]['img']),
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
                                            '4.5 كم',
                                            style: TextStyle(color: Colors.white),
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index]['name'],
                                            style: TextStyle(
                                                color: theme.isDark
                                                    ? Color.fromARGB(255, 255, 255, 255)
                                                    : Color.fromARGB(255, 0, 0, 0)),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            data[index]['desc'],
                                            style: TextStyle(
                                                color: theme.isDark
                                                    ? Color.fromARGB(255, 255, 255, 255)
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
                        );
                      })),
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
                                : Colors.black
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            navigateTo(context, PharmacyStoresScreen());
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(data.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage(data[index]['img']),
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
                                            '4.5 كم',
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
                                                data[index]['name'],
                                                style: TextStyle(color: Colors.white),
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Color(0xfff6b921),
                                                size: 20,
                                              ),
                                              Text(
                                                data[index]['rate'],
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 13),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            data[index]['desc'],
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
                        );
                      })),
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
                            navigateTo(context, PharmacyStoresScreen());
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(data.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 200,
                            height: 210,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage(data[index]['img']),
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
                                            '4.5 كم',
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
                                                data[index]['name'],
                                                style: TextStyle(color: Colors.white),
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Color(0xfff6b921),
                                                size: 20,
                                              ),
                                              Text(
                                                data[index]['rate'],
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 13),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            data[index]['desc'],
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
                        );
                      })),
                ),
              ],
            ),
          ),
        );
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
