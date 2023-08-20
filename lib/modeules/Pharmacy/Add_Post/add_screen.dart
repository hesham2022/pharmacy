import 'dart:io';

import 'package:chefaa/Shared/theme/cubit/theme_cubit.dart';
import 'package:chefaa/di/get_it.dart';
import 'package:chefaa/modeules/User/auth/presentation/usr_bloc/creat_post_cubit.dart';
import 'package:chefaa/modeules/User/auth/presentation/usr_bloc/user_cubit.dart';
import 'package:chefaa/modeules/view_stores/store_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Shared/icons.dart';
import '../../User/auth/domain/entities/create_post_params.dart';
import '../../User/auth/presentation/usr_bloc/user_cubit_state.dart';

InputDecoration _getDecoration(String hint) => InputDecoration(
      contentPadding: const EdgeInsets.all(10),
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 14.0,
        color: Color(0xffa1a1a1),
        fontWeight: FontWeight.w500,
      ),
      fillColor: Colors.white,
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

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  File? _image;
  List<String?> seconadryImages = [null, null, null, null];

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);
    setState(() {
      this._image = imageTemp;
    });
  }

  Future inserImage(int index) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = (image.path);
    setState(() {
      seconadryImages[index] = imageTemp;
    });
  }

  final prodcutNameContoller = TextEditingController();
  final brandContoller = TextEditingController();
  final quantityContoller = TextEditingController();
  final fromContoller = TextEditingController();
  final toContoller = TextEditingController();
  final desContoller = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;
  void setToDate(DateTime date) {
    toDate = date;
    toContoller.text = DateFormat.yMEd().format(date);
  }

  void setFromDate(DateTime date) {
    fromDate = date;
    fromContoller.text = DateFormat.yMEd().format(date);
  }

  bool isDateValid() => fromDate != null && toDate != null;
  String? nameValidation(String? v) =>
      v!.isEmpty ? 'please add product name' : null;
  String? brandValidation(String? v) =>
      v!.isEmpty ? 'please add brand name' : null;
  String? quantityValidation(String? v) =>
      v!.isEmpty ? 'please add quantity' : null;
  String? fromValidation(String? v) => v!.isEmpty ? 'please add date' : null;
  String? toValidation(String? v) => v!.isEmpty ? 'please add date' : null;
  String? desValidation(String? v) =>
      v!.isEmpty ? 'please add description' : null;
  final key = GlobalKey<FormState>();
  late CreatePostCubit cubit;
  @override
  void initState() {
    cubit = getIt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
    return BlocProvider<CreatePostCubit>.value(
      value: cubit,
      child: Form(
        key: key,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff089bab),
              leading: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
            body: BlocListener<CreatePostCubit, CreatePostState>(
              listener: (context, state) {
                final userId =
                    (context.read<UserCubit>().state as UserCubitStateLoaded)
                        .user
                        .id;
                print(userId);
                if (state is CreatePostStateLoaded) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StoreDetails(
                            pharmacyId: (context.read<UserCubit>().state
                                    as UserCubitStateLoaded)
                                .user
                                .id),
                      ));
                }
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: theme.isDark
                                ? Color.fromARGB(255, 24, 24, 24)
                                : Color(0xfff1f4fb)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                'offerPhoto'.tr(),
                                style: TextStyle(
                                    color: theme.isDark
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16),
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: getImage,
                                      child: Container(
                                        width: double.infinity,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: theme.isDark
                                                ? Color.fromARGB(
                                                    255, 46, 46, 46)
                                                : Color(0xfff8f8f8f8),
                                            border: Border.all(
                                              style: BorderStyle.solid,
                                              color: theme.isDark
                                                  ? Color.fromARGB(
                                                      255, 46, 46, 46)
                                                  : Color(0xfff8f8f8f8),
                                            )),
                                        child: _image != null
                                            ? Image.file(
                                                _image!,
                                                width: 350,
                                                height: 70,
                                                fit: BoxFit.cover,
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Attach a picture',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Icon(
                                                      IconBroken.Image,
                                                      color: Colors.grey,
                                                    )
                                                  ],
                                                ),
                                              ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                              seconadryImages.length, (index) {
                                            final i = seconadryImages[index];
                                            return Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () =>
                                                      inserImage(index),
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color:
                                                            Color(0xfff8f8f8),
                                                        border: Border.all(
                                                          style:
                                                              BorderStyle.solid,
                                                          color:
                                                              Color(0xffd7d7d7),
                                                        )),
                                                    child: i != null
                                                        ? Image.file(
                                                            File(i),
                                                            width: 70,
                                                            height: 50,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                IconBroken
                                                                    .Image,
                                                                color:
                                                                    Colors.grey,
                                                                size: 20,
                                                              )
                                                            ],
                                                          ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            );
                                          })),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: theme.isDark
                                ? Color.fromARGB(255, 24, 24, 24)
                                : Color(0xfff1f4fb)),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'offerInfo'.tr(),
                                style: TextStyle(
                                    color: theme.isDark
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Column(
                                    children: [
                                      productNameTextField(),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: theme.isDark
                                                ? Color.fromARGB(
                                                    255, 46, 46, 46)
                                                : Color(0xfff1f4fb),
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: brandNameTextField(),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'quantity'.tr(),
                                            style: TextStyle(
                                                color: theme.isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              controller: quantityContoller,
                                              validator: quantityValidation,
                                              decoration:
                                                  _getDecoration('quantity'),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'offerPeriod'.tr(),
                                            style: TextStyle(
                                                color: theme.isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          // Container(
                                          //   width: 70,
                                          //   height: 30,
                                          //   decoration: BoxDecoration(
                                          //     color: theme.isDark
                                          //         ? Color(0xff303030)
                                          //         : Colors.white,
                                          //   ),
                                          //   child: TextFormField(
                                          //     readOnly: true,
                                          //     onTap: () async {
                                          //       final date = await showDatePicker(
                                          //           firstDate: DateTime.now(),
                                          //           lastDate: DateTime(20234),
                                          //           initialDate: DateTime.now(),
                                          //           context: context);
                                          //       if (date != null) {
                                          //         setFromDate(date);
                                          //       }
                                          //     },
                                          //     controller: fromContoller,
                                          //     validator: toValidation,
                                          //     style: TextStyle(
                                          //         color: theme.isDark
                                          //             ? Colors.white
                                          //             : Colors.black),
                                          //     decoration: _getDecoration(''),
                                          //   ),
                                          // ),
                                          // Text(
                                          //   'to'.tr(),
                                          //   style: TextStyle(
                                          //     color: theme.isDark
                                          //         ? Colors.white
                                          //         : Colors.black,
                                          //   ),
                                          // ),
                                          // Container(
                                          //   width: 70,
                                          //   height: 30,
                                          //   decoration: BoxDecoration(
                                          //     color: theme.isDark
                                          //         ? Color(0xff303030)
                                          //         : Colors.white,
                                          //   ),
                                          //   child: TextFormField(
                                          //     readOnly: true,
                                          //     onTap: () async {
                                          //       final date = await showDatePicker(
                                          //           firstDate: DateTime.now(),
                                          //           lastDate: DateTime(20234),
                                          //           initialDate: DateTime.now(),
                                          //           context: context);
                                          //       if (date != null) {
                                          //         setToDate(date);
                                          //       }
                                          //     },
                                          //     controller: toContoller,
                                          //     validator: toValidation,
                                          //     style: TextStyle(
                                          //         color: theme.isDark
                                          //             ? Colors.white
                                          //             : Colors.black),
                                          //     decoration: _getDecoration(''),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      TextFormField(
                                        readOnly: true,
                                        onTap: () async {
                                          final date = await showDatePicker(
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(20234),
                                              initialDate: DateTime.now(),
                                              context: context);
                                          if (date != null) {
                                            setFromDate(date);
                                          }
                                        },
                                        controller: fromContoller,
                                        validator: toValidation,
                                        style: TextStyle(
                                            color: theme.isDark
                                                ? Colors.white
                                                : Colors.black),
                                        decoration: _getDecoration('from'),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'to'.tr(),
                                        style: TextStyle(
                                          color: theme.isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        readOnly: true,
                                        onTap: () async {
                                          final date = await showDatePicker(
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(20234),
                                              initialDate: DateTime.now(),
                                              context: context);
                                          if (date != null) {
                                            setToDate(date);
                                          }
                                        },
                                        controller: toContoller,
                                        validator: toValidation,
                                        style: TextStyle(
                                            color: theme.isDark
                                                ? Colors.white
                                                : Colors.black),
                                        decoration: _getDecoration(''),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        maxLines: 10,
                                        controller: desContoller,
                                        validator: desValidation,
                                        style: TextStyle(
                                            color: theme.isDark
                                                ? Colors.white
                                                : Colors.black),
                                        decoration:
                                            _getDecoration('description'),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          if (key.currentState!.validate()) {
                            final List<String> list = seconadryImages
                                .where((e) => e != null)
                                .map((element) => element as String)
                                .toList();
                            final params = CreatePostParams(
                                description: desContoller.text,
                                quantity: int.parse(quantityContoller.text),
                                form: fromDate!,
                                to: toDate!,
                                brand: brandContoller.text,
                                productName: prodcutNameContoller.text,
                                photo: _image!.path,
                                photos: list);
                            cubit.createPost(params);
                          }
                          // navigateTo(context, PharmacyLayout());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFFF089bab),
                          ),
                          child: Text(
                            'Add',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget productNameTextField() {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);

    return TextFormField(
      validator: nameValidation,
      controller: prodcutNameContoller,
      maxLines: 1,
      cursorColor: Colors.white70,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontSize: 14.0,
        color: theme.isDark ? Colors.white : Colors.black,
        fontWeight: FontWeight.w500,
      ),
      decoration: _getDecoration('productName'.tr()),
    );
  }

  Widget brandNameTextField() {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
    return TextFormField(
      validator: brandValidation,
      controller: brandContoller,
      maxLines: 1,
      cursorColor: Colors.white70,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontSize: 14.0,
        color: theme.isDark ? Colors.white : Colors.black,
        fontWeight: FontWeight.w500,
      ),
      decoration: _getDecoration('brand'.tr()),
    );
  }
}
