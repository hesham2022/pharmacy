// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jop_map/app/user/features/authentication/presentation/pages/user_create_acc.dart';
// import 'package:jop_map/app/user/features/login/presentation/bloc/login_bloc.dart';
// import 'package:jop_map/app/user/features/login/presentation/bloc/login_event.dart';
// import 'package:jop_map/app/user/features/login/presentation/bloc/login_state.dart';
// import 'package:jop_map/core/app_router/navigation_service.dart';
// import 'package:jop_map/core/enums/role.dart';
// import 'package:jop_map/core/utils/validation_regx.dart';
// import 'package:jop_map/di/get_it.dart';
// import 'package:jop_map/shared_widgets/input_field_without_prefix.dart';
// import 'package:jop_map/shared_widgets/main_buttons.dart';
// import 'package:jop_map/utils/spaces.dart';
// import 'package:jop_map/utils/texts/texts.dart';
// import 'package:jop_map/utils/theme/light_theme/light_colors.dart';

// import '../../domain/entities/login_param.dart';

// class UserLogin extends StatefulWidget {
//   UserLogin({Key? key}) : super(key: key);

//   @override
//   State<UserLogin> createState() => _UserLoginState();
// }

// class _UserLoginState extends State<UserLogin> {
//   TextEditingController agencyNameController = TextEditingController();

//   TextEditingController agencyLogoController = TextEditingController();

//   TextEditingController phoneController = TextEditingController();

//   TextEditingController responsibleNameController = TextEditingController();

//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   TextEditingController addressController = TextEditingController();

//   TextEditingController jobNameController = TextEditingController();

//   NavigationService navigation = NavigationService.navigationServiceInstance;

//   late GlobalKey<FormState> key;
//   late GestureRecognizer _longPressRecognizer;

//   @override
//   void initState() {
//     key = GlobalKey<FormState>();
//     _longPressRecognizer = TapGestureRecognizer()
//       ..onTap = () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (_) => UserCreateAccount()));
//       };
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<LoginBloc>(
//       create: (context) => getIt(),
//       child: Builder(builder: (context) {
//         return BlocListener<LoginBloc, LoginState>(
//           listener: (context, state) {
//             if (state is LoginFailure) {
//               ScaffoldMessenger.of(context)
//                   .showSnackBar(SnackBar(content: Text(state.error)));
//             }
//           },
//           child: Form(
//             key: key,
//             child: Container(
//               color: LightColors.greenColor,
//               child: SafeArea(
//                 bottom: false,
//                 child: Scaffold(
//                   body: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: Image.asset(
//                             'assets/images/create_acc_image.png',
//                             height: MediaQuery.of(context).size.height * .35,
//                             width: MediaQuery.of(context).size.width * .90,
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                         heightSpace(10),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: MediaQuery.of(context).size.width / 22,
//                           ),
//                           child: largeTitle(
//                             context: context,
//                             text: tr('login'),
//                           ),
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             heightSpace(20),
//                             // inputFieldWithoutPrefix(
//                             //   hint: tr('phone'),
//                             //   controller: phoneController,
//                             //   isEnable: true,
//                             // ),

//                             heightSpace(20),
//                             inputFieldWithoutPrefix(
//                                 hint: tr('email'),
//                                 controller: emailController,
//                                 isEnable: true,
//                                 validator: (e) =>
//                                     ValidationsPatterns.email.hasMatch(e!)
//                                         ? null
//                                         : 'Invalid email'),
//                             heightSpace(20),
//                             inputFieldWithoutPrefix(
//                                 hint: tr('password'),
//                                 controller: passwordController,
//                                 isEnable: true,
//                                 validator: (e) =>
//                                     e!.length > 6 ? null : 'Invalid password'),
//                             heightSpace(20),

//                             BlocBuilder<LoginBloc, LoginState>(
//                               builder: (context, state) {
//                                 if (state is LoginLoading)
//                                   return Center(
//                                     child: CircularProgressIndicator(),
//                                   );
//                                 return mainButton(
//                                   context: context,
//                                   text: tr('login'),
//                                   onTap: () {
//                                     if (key.currentState!.validate()) {
//                                       context.read<LoginBloc>().add(
//                                           LoginSubmitted(
//                                               LoginParam(
//                                                   email: emailController.text,
//                                                   password:
//                                                       passwordController.text),
//                                               Role.user));
//                                     }
//                                     ;
//                                     // navigation.navigateToAndClearStack(
//                                     //   context,
//                                     //   RoutesName.userHome,
//                                     // );
//                                   },
//                                   isBig: true,
//                                 );
//                               },
//                             ),
//                             heightSpace(20),
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal:
//                                     MediaQuery.of(context).size.width / 22,
//                               ),
//                               child: Text.rich(
//                                 TextSpan(
//                                     text: tr('you_do_not_have_an_account'),
//                                     recognizer: _longPressRecognizer),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
