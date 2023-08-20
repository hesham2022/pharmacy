
import 'package:chefaa/Layout/pharamcy_layout/pharmacy_layout.dart';
import 'package:chefaa/Layout/user_layout/user_layout.dart';
import 'package:chefaa/Shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PharmacyVerificationScreen extends StatefulWidget {
  const PharmacyVerificationScreen({Key? key}) : super(key: key);

  @override
  State<PharmacyVerificationScreen> createState() => _PharmacyVerificationScreenState();
}

class _PharmacyVerificationScreenState extends State<PharmacyVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff089bab),
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  shape: BoxShape.circle,
                ),
                child: Lottie.asset(
                  'assets/lottie/confirm.json',
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Congrats !',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      ),
                    ),
                    Text(
                      'your account has been sent',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "you will be contacted by administration",
                style: TextStyle(
                  fontSize: 14,

                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 70,),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    navigateTo(context, PharmacyLayout());
                  },
                  style: ButtonStyle(
                    foregroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF089BAB)),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      'Continue',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}