
import 'package:chefaa/Shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Login_Screen/login_screen.dart';
import '../SignUpScreen/signup_screen.dart';

class PharmacyWelcomeScreen extends StatefulWidget {
  const PharmacyWelcomeScreen({Key? key}) : super(key: key);

  @override
  State<PharmacyWelcomeScreen> createState() => _PharmacyWelcomeScreenState();
}

class _PharmacyWelcomeScreenState extends State<PharmacyWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff089BAB),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Lottie.asset('assets/lottie/welcomeD.json',width: 350,height: 350),
              Text('Dr Welcome to Chefaa App \n Satrt Your journey Now !',style: TextStyle(color: Colors.white,fontSize: 25),),

              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(width: 1.0, color: Colors.white),
                        ),
                          onPressed: (){
                          navigateTo(context, PharmacySignUpScreen());
                          },
                          child: Text('Sign Up'))),
                  SizedBox(width: 15,),
                  Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color.fromARGB(255, 25, 33, 34),
                          backgroundColor: Colors.white
                        ),
                          onPressed: (){
                          navigateTo(context, PharmacyLoginScreen());
                          },
                          child: Text('Login')))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
