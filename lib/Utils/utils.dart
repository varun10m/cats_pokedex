import 'package:flutter/material.dart';

Widget getTextFormField(
  TextEditingController controller,
  String labelText,
  String hintText, {
  int? validationType,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
        controller: controller,
        validator: (s) => getValidation(s),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
        )),
  );
}

getValidation(String? s) {
  return s!.isNotEmpty ? null : 'Enter Valid Details';
}

Widget getDefaultLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

void showErrorMessageInSnackBar(BuildContext context, String message,
    GlobalKey<ScaffoldState> _scaffoldKey) {
  _scaffoldKey.currentState!.showSnackBar(SnackBar(
    content: Text(
      message,
    ),
    duration: Duration(seconds: 3),
  ));
}

InputDecorationTheme buildInputDecorationTheme() {
  return InputDecorationTheme(
    border: new OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.deepOrange, width: 1.0),
    ),
  );
}

ThemeData buildThemeData() {
  return ThemeData(
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
      inputDecorationTheme: buildInputDecorationTheme(),
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      primaryColor: Colors.white,
      buttonColor: Colors.deepOrange,
      elevatedButtonTheme: defaultThemeForElevatedButton(),
      accentColor: Color(0xFFFF4081),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      focusColor: Colors.white12,
      highlightColor: Colors.white12,
      appBarTheme: AppBarTheme(
          color: Colors.white,
          actionsIconTheme: IconThemeData(color: Colors.deepOrange)));
}

ElevatedButtonThemeData defaultThemeForElevatedButton() {
  return ElevatedButtonThemeData(
      style: ButtonStyle(foregroundColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    return Colors.white;
  }), backgroundColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    return Colors.deepOrange;
  })));
}
