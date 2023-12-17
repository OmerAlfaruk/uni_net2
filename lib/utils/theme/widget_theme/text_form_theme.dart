import 'package:flutter/material.dart';
import 'package:uni_link/constant/color.dart';


class OTextFormTheme{
  static  InputDecorationTheme lightInputDecoration= const InputDecorationTheme(
      prefixIconColor: oSecondaryColor,
      border:OutlineInputBorder(),
      floatingLabelStyle: TextStyle(color: oSecondaryColor),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2,color: oSecondaryColor)
      )
  );

  static  InputDecorationTheme darkInputDecoration= const InputDecorationTheme(
      prefixIconColor:oPrimaryColor,
      border:OutlineInputBorder(),
      floatingLabelStyle: TextStyle(color: oPrimaryColor),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2,color: oPrimaryColor)
      )
  );
}