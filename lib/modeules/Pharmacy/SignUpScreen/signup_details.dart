import 'dart:convert';
import 'dart:io';

import 'package:chefaa/Shared/components/components.dart';
import 'package:chefaa/modeules/Pharmacy/SignUpScreen/ccity_model.dart';
import 'package:chefaa/modeules/Pharmacy/SignUpScreen/get_location_screen.dart';
import 'package:chefaa/modeules/Pharmacy/SignUpScreen/signup_screen.dart';
import 'package:chefaa/modeules/User/auth/data/models/user_model.dart';
import 'package:chefaa/modeules/User/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Shared/icons.dart';
import '../../User/auth/domain/entities/sign_provider_params.dart';

class SignUpDetails extends StatefulWidget {
  const SignUpDetails(
      {Key? key,
      required this.name,
      required this.email,
      required this.phone,
      required this.password})
      : super(key: key);
  final String name;
  final String email;
  final String phone;
  final String password;
  @override
  State<SignUpDetails> createState() => _SignUpDetailsState();
}

class _SignUpDetailsState extends State<SignUpDetails> {
  File? _image;
  String? valueG = 'Cairo'; // G for Gov
  String? valueR = 'Zaytoon'; // R for Region
  final gov_items = ['Cairo', 'Alex', 'Giza', 'Mansoura'];
  final reg_items = ['Nasr City', 'Mokatam', 'DownTown', 'Zaytoon'];
  final pharmacyNameController = TextEditingController();
  final regionController = TextEditingController();
  final addressDetailsController = TextEditingController();

  City? _selectedCity = null;
  List<City> cities = [];
  Future<List<City>> loadData() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/json/iq.json");
    final jsonResult = (jsonDecode(data) as List<dynamic>)
        .map((e) => City.fromJson(e))
        .toList();

    return jsonResult; //latest Dart
  }

  void selectCity(City city) => setState(() {
        _selectedCity = city;
      });
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

  List<String?> seconadryImages = [null, null, null, null];
  @override
  void initState() {
    loadData().then((value) {
      cities = [...value];
      setState(() {});
    });
    super.initState();
  }

  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print(widget.phone);
    return Form(
      key: key,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xff089bab),
            ),
            onPressed: () {
              navigateTo(context, PharmacySignUpScreen());
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {
                        loadData();
                      },
                      child: Text(' n')),
                  Image.asset('assets/images/logo.jpg'),
                  GestureDetector(
                    onTap: getImage,
                    child: Container(
                      width: double.infinity,
                      height: 80,
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
                              width: 350,
                              height: 70,
                              fit: BoxFit.cover,
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Attach a picture',
                                    style: TextStyle(color: Colors.grey),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(seconadryImages.length, (index) {
                      final i = seconadryImages[index];
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () => inserImage(index),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xfff8f8f8),
                                  border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Color(0xffd7d7d7),
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
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      );
                    }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pharmacy Name',
                          style:
                              TextStyle(color: Color(0xff4e5054), fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        pharmacyNameTextField(pharmacyNameController)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Governorate',
                                style: TextStyle(
                                    color: Color(0xff4e5054),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xfff8f8f8),
                                    border: Border.all(
                                      style: BorderStyle.solid,
                                      color: Color(0xffd7d7d7),
                                    )),
                                child: DropdownButton<City?>(
                                  value: _selectedCity,
                                  underline: Container(
                                    height: 3,
                                    color: Color(0xfff8f8f8), //<-- SEE HERE
                                  ),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xff089bab),
                                    size: 35, // <-- SEE HERE
                                  ),
                                  items: cities
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Text(
                                                e == null ? '' : e.city!,
                                                style: TextStyle(
                                                    color: Colors.grey[500],
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (e) {
                                    setState(() {
                                      _selectedCity = e;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Region',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xfff8f8f8),
                                    border: Border.all(
                                      style: BorderStyle.solid,
                                      color: Color(0xffd7d7d7),
                                    )),
                                child: TextFormField(
                                  validator: (value) => value!.isEmpty
                                      ? 'please add region '
                                      : null,
                                  controller: regionController,
                                  decoration: getDecoration('Region'),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Address Details',
                          style:
                              TextStyle(color: Color(0xff4e5054), fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        addressNameTextField(addressDetailsController)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () {
                      // navigateTo(context, OtpPharmacyScreen());
                      if (_selectedCity == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Choose City')));
                        return;
                      }
                      if (key.currentState!.validate()) {
                        final providerSignParams = RegisterProviderParams(
                          pharmacyName: pharmacyNameController.text,
                          name: widget.name,
                          email: widget.email,
                          password: widget.password,
                          phone: widget.phone,
                          address: Address(
                              coordinates: [],
                              governorate: _selectedCity!.city!,
                              id: 'id',
                              region: regionController.text,
                              details: addressDetailsController.text),
                          mainPhoto: _image!.path,
                        );
                        navigateTo(
                            context,
                            GetLocationScreen(
                              city: _selectedCity!,
                              registerProvideParams: providerSignParams,
                            ));
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xFF089bab),
                      ),
                      child: Text(
                        'Continue',
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
        ),
      ),
    );
  }
}

Widget pharmacyNameTextField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    validator: (value) => value!.isEmpty ? 'please add pharmacy name' : null,
    maxLines: 1,
    cursorColor: Colors.white70,
    keyboardType: TextInputType.emailAddress,
    style: TextStyle(
      fontSize: 14.0,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    decoration: getDecoration('Pharmacy Name'),
  );
}

Widget addressNameTextField(TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: TextFormField(
            validator: (value) =>
                value!.isEmpty ? 'please add address details' : null,
            controller: controller,
            maxLines: 1,
            cursorColor: Colors.white70,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            decoration: getDecoration('Address Details'),
          ),
        ),
      ],
    ),
  );
}
