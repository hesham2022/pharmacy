import 'package:chefaa/Layout/pharamcy_layout/pharmacy_layout.dart';
import 'package:chefaa/Layout/user_layout/user_layout.dart';

import 'package:chefaa/Shared/components/components.dart';
import 'package:chefaa/modeules/Pharmacy/view_stores/store_details.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Layout/naviigation_drawer.dart';
import '../../../Shared/icons.dart';
import '../../../Shared/theme/cubit/theme_cubit.dart';
import '../../../layout/pharamcy_layout/nav_drawer.dart';
import '../../view_stores/stores_data.dart';

class PharmacyStoresScreen extends StatefulWidget {
  const PharmacyStoresScreen({Key? key}) : super(key: key);

  @override
  State<PharmacyStoresScreen> createState() => _PharmacyStoresScreenState();
}

class _PharmacyStoresScreenState extends State<PharmacyStoresScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);

    return Scaffold(
        drawer: NavDrawer(),
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
              navigateTo(context, PharmacyLayout());
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
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
                        decoration: InputDecoration(
                            filled: true,
                            hintStyle: TextStyle(color: theme.isDark ? Colors.white : Colors.black45,),
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
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        navigateTo(context, PharmacyStoreDetails());
                      },
                      child: Card(
                        color: theme.isDark ? Color(0xff303030) : Colors.white,
                        elevation: 1.0,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              stores_data[index]['img']),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        text: TextSpan(
                                            text: stores_data[index]['name'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: theme.isDark
                                                  ? Colors.white
                                                  : Colors.black
                                            )),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        stores_data[index]['desc'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey),
                                      ),
                                    ]),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        color: theme.isDark
                                            ? Color.fromARGB(255, 56, 56, 56)
                                            : Colors.grey[200],
                                        child: Row(
                                          children: [
                                            Text(
                                              '4.5  كم',
                                              style: TextStyle(
                                                  color: theme.isDark
                                                      ? Color.fromARGB(
                                                          255, 255, 255, 255)
                                                      : Color.fromARGB(
                                                          255, 0, 0, 0),
                                                  fontSize: 13),
                                            ),
                                            SizedBox(width: 5,),
                                            Icon(
                                              Icons.location_pin,
                                              color: Color(0xff089BAB),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [

                                      Icon(
                                        Icons.star,
                                        color: Color(0xfff6b921),
                                        size: 20,
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        stores_data[index]['rate'],
                                        style: TextStyle(
                                            color: theme.isDark
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: stores_data.length,
                separatorBuilder: (BuildContext context, int index) =>Container(color: theme.isDark ? Colors.grey: Colors.white,height: 1,),
              )
            ],
          )),
        ));
  }
}
