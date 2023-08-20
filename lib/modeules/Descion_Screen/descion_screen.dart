
import 'package:chefaa/Shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Pharmacy/WelcomeScreen/welcome_screen.dart';
import '../User/WelcomeScreen/welcome_screen.dart';

class DescionScreen extends StatefulWidget {
  const DescionScreen({Key? key}) : super(key: key);

  @override
  State<DescionScreen> createState() => _DescionScreenState();
}

class _DescionScreenState extends State<DescionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){navigateTo(context,PharmacyWelcomeScreen());},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey,
                    ),
                    height: 100,

                    margin: EdgeInsets.all(20.0),
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Lottie.asset('assets/lottie/doctor.json',width: 70),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pharmacy',style: TextStyle(color: Colors.white),),
                            Text('You Can Register Your Products,\n Publish Your Offers And Receive Orders',style: TextStyle(color: Colors.white,fontSize: 12),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){navigateTo(context,UserWelcomeScreen());},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xff089BAB),
                    ),
                    height: 100,

                    margin: EdgeInsets.all(20.0),
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Lottie.asset('assets/lottie/person.json',width: 70),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Patient',style: TextStyle(color: Colors.white),),
                            Text('You Can Search For Medicines \n All Over The Country And Have Delivery \n As Soon As Possible',style: TextStyle(color: Colors.white,fontSize: 12),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20 ,),
          Container(
            decoration: BoxDecoration(
                color: Color(0xff089BAB),
              borderRadius: BorderRadius.circular(10)
            ),

            width: 300,
            height: 50.0,
            child: MaterialButton(
              onPressed: () {
                navigateTo(context, UserWelcomeScreen());
              },
              child: Text(
                'Continue',
                style: TextStyle(
                    color: Colors.white,  fontSize: 18),
              ),
            ),
          )],
            ),

          ),
        ),
      ),
    );
  }
}

