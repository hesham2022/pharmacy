import 'package:chefaa/Shared/components/components.dart';
import 'package:chefaa/core/utils/validation_regx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/role.dart';
import '../../../../../di/get_it.dart';
import '../../../WelcomeScreen/welcome_screen.dart';
import '../../domain/entities/login_param.dart';
import '../blocs/login_bloc/login_bloc.dart';
import '../blocs/login_bloc/login_event.dart';
import '../blocs/login_bloc/login_state.dart';
import 'signup_screen.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({Key? key}) : super(key: key);

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

InputDecoration getDecoration(String hint) => InputDecoration(
      contentPadding: const EdgeInsets.all(10),
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 14.0,
        color: Color(0xffa1a1a1),
        fontWeight: FontWeight.w500,
      ),
      fillColor: const Color(0xff1AA9A0).withOpacity(.1),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xff3636364d),
          width: 0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xff3636364d),
          width: 0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xff3636364d),
          width: 0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xff3636364d),
          width: 0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );

class _UserLoginScreenState extends State<UserLoginScreen> {
  bool _isHidden = true;
  bool? _isChecked = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late GlobalKey<FormState> key;
  @override
  void initState() {
    key = GlobalKey<FormState>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider<LoginBloc>(
        create: (context) => getIt(),
        child: Builder(builder: (context) {
          return BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
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
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/logo.jpg'),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email'),
                            SizedBox(
                              height: 10,
                            ),
                            emailTextField(size),
                            const SizedBox(
                              height: 30,
                            ),
                            Text('Password'),
                            SizedBox(
                              height: 10,
                            ),
                            PasswordFile(controller: passwordController),
                            const SizedBox(
                              height: 16,
                            ),
                            buildRemember(size),
                          ],
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        signInButton(size, context),
                        const SizedBox(
                          height: 100,
                        ),
                        buildFooter(size),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }

  Widget logo() {
    return Image.asset(
      'assets/images/logo.jpg',
      height: 70,
      width: 200,
    );
  }

  Widget emailTextField(Size size) {
    return TextFormField(
      scrollPadding: EdgeInsets.all(200),
      controller: emailController,
      validator: (value) {
        return !ValidationsPatterns.email.hasMatch(value!)
            ? 'invalid email'
            : null;
      },
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

  Widget passwordTextField(Size size) {
    return TextFormField(
      scrollPadding: EdgeInsets.all(100),
      controller: passwordController,
      validator: (value) {
        return !ValidationsPatterns.passwordValidate.hasMatch(value!)
            ? 'weak password'
            : null;
      },
      maxLines: 1,
      cursorColor: Color(0xff098bab),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      decoration: getDecoration('Password'),
    );
  }

  Widget buildRemember(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: 17.0,
          height: 17.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Checkbox(
            activeColor: Color(0xff098bab),
            value: _isChecked,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onChanged: (value) {
              setState(() {
                _isChecked = value;
              });
            },
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          'Remember me',
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xff67696c),
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget signInButton(Size size, BuildContext context) {
    return MaterialButton(
      onPressed: () {
        if (key.currentState!.validate())
          context.read<LoginBloc>().add(LoginSubmitted(
              LoginParam(
                  email: emailController.text,
                  password: passwordController.text),
              Role.user));
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
          'Login',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  Widget buildFooter(Size size) {
    return Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dont Have Account?',
              style: TextStyle(
                  color: Color.fromARGB(255, 1, 2, 2),
                  fontWeight: FontWeight.w300,
                  fontSize: 14),
            ),
            SizedBox(
              width: 15,
            ),
            TextButton(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: const Color(0xFFF089BAB),
                      fontWeight: FontWeight.w300,
                      fontSize: 14),
                ),
                onPressed: () {
                  navigateTo(context, UserSignUp());
                })
          ],
        ));
  }
}

class PasswordFile extends StatefulWidget {
  PasswordFile(
      {super.key, required this.controller, this.validator, this.hint});
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hint;
  @override
  State<PasswordFile> createState() => _PasswordFileState();
}

class _PasswordFileState extends State<PasswordFile> {
  bool _isHidden = true;
  InputDecoration getDecoration(
    String hint,
  ) =>
      InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 14.0,
          color: Color(0xffa1a1a1),
          fontWeight: FontWeight.w500,
        ),
        fillColor: const Color(0xff1AA9A0).withOpacity(.1),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff3636364d),
            width: 0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff3636364d),
            width: 0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff3636364d),
            width: 0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff3636364d),
            width: 0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              if (_isHidden) {
                _isHidden = false;
              } else {
                _isHidden = true;
              }
            });
          },
          icon: Icon(
            _isHidden == true
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Color(0xff089bab),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // scrollPadding: EdgeInsets.all(100),
      controller: widget.controller,
      validator: widget.validator ??
          (value) {
            print(ValidationsPatterns.passwordValidate.hasMatch(value!));
            return value.length < 8 ? 'weak password' : null;
          },
      maxLines: 1,
      cursorColor: Color(0xff098bab),
      keyboardType: TextInputType.visiblePassword,
      obscureText: _isHidden,
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      decoration: getDecoration(widget.hint ?? 'Password'),
    );
  }
}
