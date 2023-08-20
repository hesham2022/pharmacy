import 'package:chefaa/modeules/Pharmacy/SignUpScreen/signup_details.dart';
import 'package:flutter/material.dart';

import '../../../Shared/components/components.dart';
import '../../../core/utils/validation_regx.dart';
import '../../User/auth/presentation/pages/login_screen.dart';
import '../WelcomeScreen/welcome_screen.dart';

class PharmacySignUpScreen extends StatefulWidget {
  const PharmacySignUpScreen({Key? key}) : super(key: key);

  @override
  State<PharmacySignUpScreen> createState() => _PharmacySignUpScreenState();
}

bool _isHidden = true;

class _PharmacySignUpScreenState extends State<PharmacySignUpScreen> {
  late GlobalKey<FormState> key;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final photoController = TextEditingController();
  @override
  void initState() {
    key = GlobalKey<FormState>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: key,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              navigateTo(context, PharmacyWelcomeScreen());
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Color(0xff098bab),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.jpg',
                  height: 100,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Full Name'),
                    SizedBox(
                      height: 10,
                    ),
                    nameTextField(),
                    const SizedBox(
                      height: 30,
                    ),
                    Text('Email'),
                    SizedBox(
                      height: 10,
                    ),
                    emailTextField(),
                    SizedBox(
                      height: 20,
                    ),
                    phoneTextField(),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Password'),
                    SizedBox(
                      height: 10,
                    ),
                    passwordTextField(),
                    SizedBox(
                      height: 10,
                    ),
                    confirmPasswordTextField(),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                //sign in button & continue with text here
                signUpButton(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logo() {
    return Image.asset(
      'assets/images/logo.jpg',
      height: 70,
      width: 200,
    );
  }

  Widget emailTextField() {
    return TextFormField(
      controller: emailController,
      validator: (value) =>
          ValidationsPatterns.email.hasMatch(value!) ? null : 'invalid email',
      maxLines: 1,
      cursorColor: Colors.white70,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      decoration: getDecoration('Email'),
    );
  }

  String? validateMobile(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value!.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  Widget phoneTextField() {
    return TextFormField(
      controller: phoneController,
      validator: validateMobile,
      maxLines: 1,
      cursorColor: Colors.white70,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      decoration: getDecoration('Phone Number'),
    );
  }

  Widget nameTextField() {
    return TextFormField(
      controller: nameController,
      validator: (value) => value!.isNotEmpty ? null : 'please provide name',
      maxLines: 1,
      cursorColor: Colors.white70,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      decoration: getDecoration('Full Name'),
    );
  }

  Widget passwordTextField() {
    return PasswordFile(
      controller: passwordController,
    );
  }

  Widget confirmPasswordTextField() {
    return PasswordFile(
      hint: 'Confirm Password',
      controller: confirmPasswordController,
      validator: (value) =>
          passwordController.text == value! ? null : 'not identical',
    );
  }

  Widget signUpButton(Size size) {
    return MaterialButton(
      onPressed: () {
        if (key.currentState!.validate())
          navigateTo(
              context,
              SignUpDetails(
                password: passwordController.text,
                name: nameController.text,
                email: emailController.text,
                phone: phoneController.text,
              ));
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFFF089BAB),
        ),
        child: Text(
          'Continue',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
