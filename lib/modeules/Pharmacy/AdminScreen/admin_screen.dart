import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../../Shared/theme/cubit/theme_cubit.dart';
import 'line.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);

    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Stack(children: [
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    color: Color(0xff089bab),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    height: 150,
                    child: PieChart(PieChartData(sections: showingSections())),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              '800',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'followers'.tr(),
                              style: TextStyle(color: Colors.white),
                            ),
                            LinearPercentIndicator(
                              width: 120,
                              percent: 90 / 100,
                              backgroundColor: Color(0xff007d8a),
                              progressColor: Color(0xff133f63),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SmoothStarRating(
                              starCount: 5,
                              rating: 4.3,
                              size: 15,
                              color: Color(0xfff6b921),
                              borderColor: Color(0xfff6b921),
                            ),
                            Text(
                              'reviews'.tr(),
                              style: TextStyle(color: Colors.white),
                            ),
                            LinearPercentIndicator(
                              width: 120,
                              percent: 60 / 100,
                              backgroundColor: Color(0xff007d8a),
                              progressColor: Color(0xfff1cf7b),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '90%',
                                      style: TextStyle(
                                          color: Color(0xff01d20a), fontSize: 15),
                                    ),
                                    Text(
                                      'feedBack'.tr(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ],
                                ),

                              ],
                            ),

                            LinearPercentIndicator(
                              width: 120,
                              percent: 60 / 100,
                              backgroundColor: Color(0xff007d8a),
                              progressColor: Color(0xffa4aaff),
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ]),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'visitors'.tr(),
                        style: TextStyle(color: Color(0xff089bab)),
                      ),
                      Text('week'.tr(),style: TextStyle(color: theme.isDark ?  Colors.white : Color(0xff303030),),)
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '↑ %80',
                        style: TextStyle(color: Color(0xff098c26)),
                      ),
                      Text('week'.tr(),style: TextStyle(color: theme.isDark ?  Colors.white : Color(0xff303030),),)
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child:
                  Container(height: 200, width: 400, child: LineChartSample2()),
            )
          ],
        ),
      ),
    ));
  }
}

List<PieChartSectionData> showingSections() {
  return List.generate(3, (i) {
    switch (i) {
      case 0:
        return PieChartSectionData(
          value: 50,
          color: const Color(0xff133f63),
          radius: 30,
        );
      case 1:
        return PieChartSectionData(
          color: const Color(0xfff1cf7b),
          radius: 30,
        );
      case 2:
        return PieChartSectionData(
          color: const Color(0xff845bef),
          radius: 30,
        );

      default:
        throw Error();
    }
  });
}
