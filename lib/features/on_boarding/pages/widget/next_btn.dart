import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/sizes.dart';
import 'package:uni_link/features/on_boarding/controller/on_boarding_controller.dart';
import 'package:uni_link/utils/device/device_utility.dart';
import 'package:uni_link/utils/helpers/helper_functions.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = OHelperFunctions.isDark(context);
    return Positioned(
        right: OSizes.defaultSpace,
        bottom: ODeviceUtils.getAppBarHeight(),
        child: ElevatedButton(
          onPressed: () {
            OnBoardingController.instance.nexPage();
          },
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: dark ? oPrimaryColor : Colors.black),
          child: const Icon(Iconsax.arrow_right_3),
        ));
  }
}
