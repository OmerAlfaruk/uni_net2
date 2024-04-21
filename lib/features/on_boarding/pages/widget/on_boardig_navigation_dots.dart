import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/sizes.dart';
import 'package:uni_link/features/on_boarding/controller/on_boarding_controller.dart';

import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = OHelperFunctions.isDark(context);
    return Positioned(
      bottom: ODeviceUtils.getBottomNavigationBarHeight() + 25,
      left: OSizes.defaultSpace,
      child: SmoothPageIndicator(
        effect: ExpandingDotsEffect(
            activeDotColor: dark ? oLightColor : oDarkColor, dotHeight: 6),
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
      ),
    );
  }
}
