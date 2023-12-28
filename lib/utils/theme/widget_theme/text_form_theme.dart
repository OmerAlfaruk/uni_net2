import 'package:flutter/material.dart';
import 'package:uni_link/constant/color.dart';


class OTextFormTheme{
  static  InputDecorationTheme lightInputDecoration=  InputDecorationTheme(
      prefixIconColor: oSecondaryColor,
      border:OutlineInputBorder(),

      floatingLabelStyle: TextStyle(color: oSecondaryColor),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 2,color: oSecondaryColor)
      )
  );

  static  InputDecorationTheme darkInputDecoration= InputDecorationTheme(
      prefixIconColor:oPrimaryColor,
      border:OutlineInputBorder(),
      floatingLabelStyle: TextStyle(color: oPrimaryColor),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 2,color: oPrimaryColor)
      )
  );
}