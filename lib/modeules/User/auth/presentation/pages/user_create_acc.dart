// import 'package:country_picker/country_picker.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:jop_map/app/user/features/authentication/domain/entities/entities.dart';
// import 'package:jop_map/app/user/features/login/presentation/bloc/login_bloc.dart';
// import 'package:jop_map/app/user/features/login/presentation/bloc/login_event.dart';
// import 'package:jop_map/app/user/features/login/presentation/bloc/login_state.dart';
// import 'package:jop_map/core/app_router/navigation_service.dart';
// import 'package:jop_map/di/get_it.dart';
// import 'package:jop_map/shared_widgets/add_image.dart';
// import 'package:jop_map/shared_widgets/input_field_without_prefix.dart';
// import 'package:jop_map/shared_widgets/main_buttons.dart';
// import 'package:jop_map/utils/spaces.dart';
// import 'package:jop_map/utils/texts/texts.dart';
// import 'package:jop_map/utils/theme/light_theme/light_colors.dart';

// import '../../../../../../shared_widgets/phone_input.dart';
// import '../../data/models/user_model.dart';

// class UserCreateAccount extends StatefulWidget {
//   UserCreateAccount({Key? key}) : super(key: key);

//   @override
//   State<UserCreateAccount> createState() => _UserCreateAccountState();
// }

// class _UserCreateAccountState extends State<UserCreateAccount> {
//   TextEditingController agencyNameController = TextEditingController();

//   TextEditingController agencyLogoController = TextEditingController();

//   TextEditingController phoneController = TextEditingController();

//   TextEditingController responsibleNameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   TextEditingController emailController = TextEditingController();
//   TextEditingController photoController = TextEditingController();

//   TextEditingController ageController = TextEditingController();

//   TextEditingController addressController = TextEditingController();

//   TextEditingController jobNameController = TextEditingController();
//   Country? countery;
//   void showCounterCode() {
//     showCountryPicker(
//       context: context,
//       countryListTheme: CountryListThemeData(
//         flagSize: 25,
//         backgroundColor: Colors.white,
//         textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
//         bottomSheetHeight: 500, // Optional. Country list modal height
//         //Optional. Sets the border radius for the bottomsheet.
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20.0),
//           topRight: Radius.circular(20.0),
//         ),
//         //Optional. Styles the search field.
//         inputDecoration: InputDecoration(
//           labelText: 'Search',
//           hintText: 'Start typing to search',
//           prefixIcon: const Icon(Icons.search),
//           border: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: const Color(0xFF8C98A8).withOpacity(0.2),
//             ),
//           ),
//         ),
//       ),
//       onSelect: (Country countryx) {
//         setState(() {
//           countery = countryx;
//         });
//         print('Select country: ${countryx.displayName}');
//       },
//     );
//   }

//   NavigationService navigation = NavigationService.navigationServiceInstance;
//   Future<void> getPhoto() async {
//     final ImagePicker _picker = ImagePicker();
//     // Pick an image
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       photoController.text = image.path;
//       print(photoController.text);

//       setState(() {});
//     }
//     ;
//   }

//   PhoneNumber? phoneNumber;
//   late GlobalKey<FormState> key;
//   @override
//   void initState() {
//     key = GlobalKey<FormState>();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<SingUpBloc>(
//       create: (context) => getIt(),
//       child: Form(
//         key: key,
//         child: Container(
//           color: LightColors.greenColor,
//           child: SafeArea(
//             bottom: false,
//             child: Scaffold(
//               body: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: Image.asset(
//                         'assets/images/create_acc_image.png',
//                         height: MediaQuery.of(context).size.height * .35,
//                         width: MediaQuery.of(context).size.width * .90,
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                     heightSpace(10),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: MediaQuery.of(context).size.width / 22,
//                       ),
//                       child: largeTitle(
//                         context: context,
//                         text: tr('subscribe_data'),
//                       ),
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         heightSpace(20),
//                         inputFieldWithoutPrefix(
//                           hint: tr('full_name'),
//                           controller: agencyNameController,
//                           isEnable: true,
//                         ),
//                         heightSpace(25),
//                         inputFieldWithoutPrefix(
//                           hint: tr('password'),
//                           controller: passwordController,
//                           isEnable: true,
//                         ),
//                         heightSpace(25),
//                         inputFieldWithoutPrefix(
//                           hint: tr('age'),
//                           controller: ageController,
//                           isEnable: true,
//                         ),
//                         // heightSpace(20),
//                         // inputFieldWithoutPrefix(
//                         //   hint: tr('phone'),
//                         //   controller: phoneController,
//                         //   isEnable: true,
//                         // ),
//                         heightSpace(20),
//                         PhonrInput(
//                           controller: phoneController,
//                           onInputChange: (p0) {
//                             phoneNumber = p0;
//                             print(p0);
//                             setState(() {});
//                           },
//                         ),
//                         // Text(phoneNumber!.phoneNumber.toString()),
//                         // TextButton(
//                         //     onPressed: () {
//                         //       showCounterCode();
//                         //     },
//                         //     child: Text(countery != null
//                         //         ? countery!.displayName +
//                         //             ' ' +
//                         //             countery!.countryCode
//                         //         : 'select code')),
//                         heightSpace(20),
//                         inputFieldWithoutPrefix(
//                           hint: tr('address'),
//                           controller: addressController,
//                           isEnable: true,
//                         ),
//                         heightSpace(20),
//                         inputFieldWithoutPrefix(
//                           hint: tr('email'),
//                           controller: emailController,
//                           isEnable: true,
//                         ),
//                         heightSpace(20),
//                         inputFieldWithoutPrefix(
//                           hint: tr('job_name'),
//                           controller: jobNameController,
//                           isEnable: true,
//                         ),
//                         heightSpace(20),
//                         if (photoController.text.isNotEmpty)
//                           PickedImage(image: photoController.text)
//                         else
//                           addImage(
//                             context,
//                             title: tr('add_personal_image'),
//                             onTap: () {
//                               getPhoto();
//                             },
//                             color: Colors.white,
//                           ),
//                         heightSpace(20),
//                         BlocBuilder<SingUpBloc, LoginState>(
//                           builder: (context, state) {
//                             if (state is LoginLoading)
//                               return Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             return mainButton(
//                               context: context,
//                               text: tr('create_account'),
//                               onTap: () {
//                                 if (key.currentState!.validate()) {
//                                   context.read<SingUpBloc>().add(
//                                       LoginRegisterSubmitted(SignParam(
//                                           name: agencyNameController.text,
//                                           password: passwordController.text,
//                                           email: emailController.text,
//                                           phone: phoneNumber!.phoneNumber
//                                               .toString(),
//                                           jobTitle: jobNameController.text,
//                                           photo: photoController.text,
//                                           age: int.parse(ageController.text),
//                                           address: Address(
//                                               id: '',
//                                               coordinates: [23, 23],
//                                               address: 'Cairo',
//                                               description: 'Cairo'))));
//                                   // showDialog(
//                                   //     context: context,
//                                   //     builder: (_) => Dialog(
//                                   //           child: Container(),
//                                   //         ));
//                                 }
//                                 ;
//                                 // navigation.navigateToAndClearStack(
//                                 //   context,
//                                 //   RoutesName.userHome,
//                                 // );
//                               },
//                               isBig: true,
//                             );
//                           },
//                         ),
//                         heightSpace(20),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
