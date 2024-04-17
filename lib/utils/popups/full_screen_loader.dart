

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_link/constant/color.dart';
import '../../common_widget/loader/animation_loader.dart';
import '../helpers/helper_functions.dart';

class FullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      builder: (_) => PopScope(
        child: Container(
          color: OHelperFunctions.isDark(Get.context!)
              ? oDarkColor
              : oWhiteColor,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 250,
              ),
              AnimationLoaderWidget(
                text: text,
                animation: animation,
              )
            ],
          ),
        ),
      ),
    );

  }
  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop();
  }
}
