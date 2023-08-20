

import 'package:chefaa/Shared/components/app_styles.dart';
import 'package:chefaa/Shared/components/size_configs.dart';
import 'package:chefaa/Shared/components/widgets/onboard_nav_btn.dart';
import 'package:chefaa/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Shared/components/widgets/my_text_button.dart';
import '../Descion_Screen/descion_screen.dart';
import 'onboard_data.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPage = 0;

  PageController _pageController = PageController(initialPage: 0);

  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      duration: Duration(milliseconds: 400),
      height: 8,
      width: currentPage == index ? 20:6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Colors.grey,
        borderRadius: BorderRadius.circular(3)
      ),
    );
  }

  Future setSeenonboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    seenOnboard = await prefs.setBool('seenOnboard', true);
    // this will set seenOnboard to true when running onboard page for first time.
  }

  @override
  void initState() {
    super.initState();
    setSeenonboard();
  }

  @override
  Widget build(BuildContext context) {
    // initialize size config
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: onboardingContents.length,
                  itemBuilder: (context, index) => Column(
                    children: [

                      SizedBox(
                        height: sizeV * 5,
                      ),
                      Container(
                        height: sizeV * 50,
                        child: Lottie.asset(
                          onboardingContents[index].image,

                        ),

                      ),
                      SizedBox(
                        height: sizeV * 5,
                      ),
                      Text(
                        onboardingContents[index].title,
                        style: kTitle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: sizeV * 2,
                      ),
                      Text(
                        onboardingContents[index].desc,
                        style: kBodyText1,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: sizeV * 5,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    currentPage == onboardingContents.length - 1
                        ? MyTextButton(

                      buttonName: 'Start Now',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DescionScreen(),
                            ));
                      },
                      bgColor: kPrimaryColor,
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OnBoardNavBtn(
                          name: 'Skip',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DescionScreen()));
                          },
                        ),
                        Row(
                          children: List.generate(
                            onboardingContents.length,
                                (index) => dotIndicator(index),
                          ),
                        ),

                        Container(
                          width: 80,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xff089BAB),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Center(child: Text('Next',style: TextStyle(color: Colors.white),)),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}