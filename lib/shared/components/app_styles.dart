import 'package:flutter/material.dart';
import './size_configs.dart';

const Color kPrimaryColor = Color(0xff089BAB);
const Color kSecondaryColor = Color(0xff000000);
const Color kScaffoldBackground = Color(0xffFFF3E9);

final kTitle = TextStyle(
  fontFamily: 'Madina',
  fontSize: SizeConfig.blockSizeH! * 7,
  color: kSecondaryColor,
);

final kTitle2 = TextStyle(
  fontFamily: 'Madina',
  fontSize: SizeConfig.blockSizeH! * 6,
  color: kSecondaryColor,
);

final kBodyText1 = TextStyle(
  color: Colors.black38,
  fontSize: SizeConfig.blockSizeH! * 4.5,

);

final kBodyText2 = TextStyle(
  color: kSecondaryColor,
  fontSize: SizeConfig.blockSizeH! * 4,
  fontWeight: FontWeight.bold,
);

final kBodyText3 = TextStyle(
    color: kSecondaryColor,
    fontSize: SizeConfig.blockSizeH! * 3.8,
    fontWeight: FontWeight.normal);
