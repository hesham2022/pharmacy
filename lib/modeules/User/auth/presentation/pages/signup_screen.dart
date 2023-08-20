import 'dart:io';

import 'package:chefaa/Shared/components/components.dart';
import 'package:chefaa/core/utils/validation_regx.dart';
import 'package:chefaa/di/get_it.dart';
import 'package:chefaa/modeules/User/auth/presentation/blocs/login_bloc/login_event.dart';
import 'package:chefaa/modeules/User/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../Shared/icons.dart';
import '../../../WelcomeScreen/welcome_screen.dart';
import '../../domain/entities/sign_param.dart';
import '../blocs/login_bloc/login_bloc.dart';
import '../blocs/login_bloc/login_state.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({Key? key}) : super(key: key);

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

bool _isHidden = true;

class _UserSignUpState extends State<UserSignUp> {
  late GlobalKey<FormState> key;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final photoController = TextEditingController();
  File? _image;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);
    setState(() {
      this._image = imageTemp;
      photoController.text = _image!.path;
    });
  }

  @override
  void initState() {
    key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider<SingUpBloc>(
      create: (context) => getIt(),
      child: Form(
        key: key,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                navigateTo(context, UserWelcomeScreen());
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: getImage,
                            child: Container(
                              width: 200,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xfff8f8f8),
                                  border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Color(0xffd7d7d7),
                                  )),
                              child: _image != null
                                  ? Image.file(
                                      _image!,
                                      width: 70,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          IconBroken.Image,
                                          color: Colors.grey,
                                          size: 20,
                                        )
                                      ],
                                    ),
                            ),
                          ),
                        ],
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
    return BlocBuilder<SingUpBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        return MaterialButton(
          onPressed: () {
            // navigateTo(context, OtpScreenUser());
            print(key.currentState);
            if (key.currentState!.validate())
              context.read<SingUpBloc>().add(LoginRegisterSubmitted(SignParam(
                  photo: photoController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  name: nameController.text)));
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
              'Sign Up',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        );
      },
    );
  }
}
