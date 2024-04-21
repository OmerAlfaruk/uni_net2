import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_link/constant/image_string.dart';
import 'package:uni_link/constant/text_string.dart';
import 'package:uni_link/features/on_boarding/controller/on_boarding_controller.dart';
import 'package:uni_link/features/on_boarding/pages/widget/next_btn.dart';
import 'package:uni_link/features/on_boarding/pages/widget/on_boardig_navigation_dots.dart';
import 'package:uni_link/features/on_boarding/pages/widget/on_boarding_widget.dart';
import 'package:uni_link/features/on_boarding/pages/widget/skip.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          /// horizontal Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoarding(
                  title: onBoardingTitle1,
                  image: onBoardingImage1,
                  subTitle: onBoardingSubTitle1),
              OnBoarding(
                  title: onBoardingTitle2,
                  image: onBoardingImage2,
                  subTitle: onBoardingSubTitle2),
              OnBoarding(
                  title: onBoardingTitle3,
                  image: onBoardingImage3,
                  subTitle: onBoardingSubTitle3),
            ],
          ),

          /// Skip Button
          const Skip(),

          /// Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),

          /// Circular Button

          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
