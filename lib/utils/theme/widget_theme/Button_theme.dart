import 'package:flutter/material.dart';

import '../../../constant/color.dart';

class OElevatedButtonTheme {
 static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: oPrimaryColor,
      backgroundColor: oDarkColor,
      shape: const RoundedRectangleBorder(),
      side: const BorderSide(color: oPrimaryColor),
    ),
  );
 static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: oPrimaryColor,
      backgroundColor: oDarkColor,
      shape: const RoundedRectangleBorder(),
      side: const BorderSide(color: oPrimaryColor),
    ),
  );
}

class OOutLinedButtonTheme {
 static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    foregroundColor: oDarkColor,
    backgroundColor: oWhiteColor,

    shape: const RoundedRectangleBorder(),
    side: const BorderSide(color: Colors.black26),
  ));
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: oDarkColor,
        backgroundColor: oPrimaryColor,
    shape: const RoundedRectangleBorder(),
    side: const BorderSide(color: Colors.black26),
  ));
}
