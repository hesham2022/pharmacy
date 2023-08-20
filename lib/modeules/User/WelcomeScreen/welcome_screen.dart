
import 'package:chefaa/Shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../auth/presentation/pages/login_screen.dart';
import '../auth/presentation/pages/signup_screen.dart';

class UserWelcomeScreen extends StatefulWidget {
  const UserWelcomeScreen({Key? key}) : super(key: key);

  @override
  State<UserWelcomeScreen> createState() => _UserWelcomeScreenState();
}

class _UserWelcomeScreenState extends State<UserWelcomeScreen> {
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
              Lottie.asset('assets/lottie/welcome.json'),
              Text('Welcome to Chefaa App \n Satrt Your journey Now !',style: TextStyle(color: Colors.white,fontSize: 25),),

              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(width: 1.0, color: Colors.white),
                        ),
                          onPressed: (){
                          navigateTo(context, UserSignUp());
                          },
                          child: Text('Sign Up'))),
                  SizedBox(width: 15,),
                  Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color(0xff089BAB),
                          backgroundColor: Colors.white
                        ),
                          onPressed: (){
                          navigateTo(context, UserLoginScreen());
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
