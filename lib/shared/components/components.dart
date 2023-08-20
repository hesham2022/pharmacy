import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String text,
  required Color color,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text,
        style: TextStyle(color: color),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

Widget signInForm({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  required Function validate,
  required String label,
  required String hint,
  required Function onChange,
  required Function onTap,
  required Function onSubmit,
  required IconData suffix,
  required Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit(),
      onChanged: onChange(),
      onTap: onTap(),
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: suffix != null
                ? IconButton(
                    onPressed: suffixPressed(),
                    icon: Icon(
                      suffix,
                    ),
                  )
                : null),
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10.0,
        ),
      ),
    );



Widget formTextField({
  required TextEditingController controller,
  required TextInputType type,
  required Function onSubmit,
  required String lable,
  required String hint,
  required IconData suffix,
}) =>
    TextFormField(
      controller: controller,
      onFieldSubmitted: onSubmit(),
      keyboardType: type,
      decoration: InputDecoration(
        suffixIcon: Icon(suffix),
        labelText: lable,
        hintText: hint,
        border: OutlineInputBorder(),
      ),
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}
