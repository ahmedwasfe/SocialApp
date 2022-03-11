import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled1/style/colors.dart';

Widget CustomButton({
  required String text,
  required Function() click,
  double width = double.infinity,
  double height = 48.0,
  Color background = Colors.blueAccent,
  bool isUpperCase = true,
  Color textColor = Colors.white,
  double radius = 0.0,
  double marginLeft = 0.0,
}) =>
    Container(
      margin: EdgeInsets.only(left: marginLeft),
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: click,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: textColor),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );

Widget CustomFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String lable,
  required IconData prefix,
  required FormFieldValidator<String> validate,
  bool isEnable = true,
  IconData? suffix,
  GestureTapCallback? onTab,
  Function()? suffixClick,
  ValueChanged? onChange,
  ValueChanged? onSubmit,
  bool isPassword = false,
  double radius = 8.0,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: isEnable,
      obscureText: isPassword,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      onTap: onTab,
      validator: validate,
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixClick,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );


Widget buildSeperator() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 25.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, screen) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));

void navigateAndFinish(context, screen) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
    (Route<dynamic> route) => false);

void showToast({
  required String message,
  required ToastStates state,
}) => Fluttertoast
    .showToast(msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: chooseToastColor(state),
    timeInSecForIosWeb: 5,
    textColor: Colors.white);

enum ToastStates {SUCCESS, FAILED, WARNING, OTHERS}

Color chooseToastColor(ToastStates toastStates){
Color? color;
  switch(toastStates){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.FAILED:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.OTHERS:
      color = Colors.black;
      break;
    default:
      color = Colors.black;
  }
  return color;
}
