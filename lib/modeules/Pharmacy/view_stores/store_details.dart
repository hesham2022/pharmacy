
import 'package:chefaa/Shared/components/components.dart';
import 'package:chefaa/Shared/icons.dart';
import 'package:chefaa/modeules/Pharmacy/view_stores/post_details.dart';
import 'package:chefaa/modeules/Pharmacy/view_stores/stores_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../../Shared/theme/cubit/theme_cubit.dart';
import '../../view_stores/card_screen.dart';
import '../../view_stores/review_list.dart';

class PharmacyStoreDetails extends StatefulWidget {
  const PharmacyStoreDetails({Key? key}) : super(key: key);

  @override
  State<PharmacyStoreDetails> createState() => _PharmacyStoreDetailsState();
}

class _PharmacyStoreDetailsState extends State<PharmacyStoreDetails> {
  var selected = 0;
  bool isMore = false;
  List<double> ratings = [0.1, 0.3, 0.5, 0.7, 0.9];
  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);

    var menu = ['posts'.tr(), 'reviews'.tr()];
    const icons = <IconData>[Icons.article, Icons.reviews];
    return Scaffold(
      appBar: AppBar(
        backgroundColor:theme.isDark ? Color(0xff303030) : Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Saydlety',
          style: TextStyle(color: Color(0xff089BAB)),
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cGVyc29uJTIwYXZhdGFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60')),
            onPressed: () {
              Builder(builder: (context) {
                return IconButton(
                  icon: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cGVyc29uJTIwYXZhdGFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60')),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              });
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xff089BAB),
          ),
          onPressed: () {
            navigateTo(context, PharmacyStoresScreen());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://f.hubspotusercontent10.net/hub/491011/hubfs/pharmacy-background.jpg?length=2000&name=pharmacy-background.jpg'))),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Text(
                  'El Ezaby Pharmacy',
                  style: TextStyle(
                      color: Color(0xff089BAB),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Text('200'),
                  Text(
                    'Followers',
                    style: TextStyle(color: Colors.grey[500]),
                  )
                ],
              ),
              Column(
                children: [
                  Text('50'),
                  Text(
                    'Products',
                    style: TextStyle(color: Colors.grey[500]),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {},
                child: Text(
                  'follow'.tr(),
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                color: Color(0xff089BAB),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minWidth: 100,
              ),
              MaterialButton(
                onPressed: () {},
                child: Text(
                  'msg'.tr(),
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                color: Color(0xffcce7ea),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minWidth: 100,
              ),
              MaterialButton(
                onPressed: () {},
                child: Text(
                  'contact'.tr(),
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                color: Color(0xffcce7ea),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minWidth: 100,
              ),
            ],
          ),
          SizedBox(
            height: 15,
            width: 15,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Icon(
                  IconBroken.Location,
                  color: Color(0xff089BAB),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'address'.tr(),
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Icon(
            IconBroken.Time_Circle,
                  color: Color(0xff089BAB),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'work24'.tr(),
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            decoration: const BoxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(menu.length, (index) {
                var name = menu[index];
                var icon = icons[index];
                return InkWell(
                  onTap: () {
                    selected = index;

                    setState(() {});
                  },
                  child: Container(
                    height: 200.0,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icon,
                              color: selected == index
                                  ? Color(0xff089BAB)
                                  : Colors.grey,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(name,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: selected == index
                                        ? Color(0xff089BAB)
                                        : Colors.grey)),
                          ],
                        ),
                        const Spacer(),
                        (selected == index)
                            ? Container(
                                height: 2.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xff089BAB),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      16.0,
                                    ),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          Container(
            height: 350.0,
            margin: const EdgeInsets.symmetric(horizontal: 25.0),
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: IndexedStack(index: selected, children: [
              InkWell(
                onTap: () {
                  navigateTo(context, PharmacyPostDetails());
                },
                child: Container(
                    decoration: const BoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: posts_details.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      posts_details[index]['img']))),
                        ),
                      ),
                    )),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: theme.isDark
                            ? Color.fromARGB(255, 23, 23, 23)
                            : Colors.grey[200],
                      ),
                      width: double.infinity,

                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "4.5",
                                      style: TextStyle(fontSize: 30.0,color: theme.isDark
                                          ? Colors.white
                                          : Colors.black),
                                    ),
                                    TextSpan(
                                      text: "/5",
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        color: kLightColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SmoothStarRating(
                                starCount: 5,
                                rating: 4.3,
                                size: 28.0,
                                color: Color(0xfff6b921),
                                borderColor: Color(0xfff6b921),
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                "Reviews : ${review_list.length}",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: kLightColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Container(
                            width: 150.0,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              reverse: true,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Text(
                                      "${index + 1}",
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    SizedBox(width: 1.0),
                                    Icon(Icons.star, color: Color(0xfff6b921)),
                                    SizedBox(width: 8.0),
                                    LinearPercentIndicator(
                                      lineHeight: 6.0,
                                      // linearStrokeCap: LinearStrokeCap.roundAll,
                                      width: 100,
                                      animation: true,
                                      animationDuration: 2500,
                                      percent: ratings[index],
                                      progressColor: Color(0xfff6b921),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.isDark
                            ? Color.fromARGB(255, 23, 23, 23)
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: review_list.length,
                        itemBuilder: (contex, index) => Container(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SmoothStarRating(
                                      spacing: 0.5,
                                      starCount: 5,
                                      rating: 4.3,
                                      size: 15.0,
                                      color: Color(0xfff6b921),
                                      borderColor: Color(0xfff6b921),
                                    ),
                                    Text(
                                      review_list[index]['date'],
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(review_list[index]['comment'],style: TextStyle(color: theme.isDark
                                        ? Colors.white
                                        : Colors.black),),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "By :",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          review_list[index]['name'],
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        separatorBuilder: (BuildContext context, int index) =>
                            Container(
                          height: 15,
                          color: theme.isDark
                              ? Color(0xff303030)
                              : Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]),
          )
        ]),
      ),
    );
  }
}
