import 'package:flutter/material.dart';
import 'package:uni_link/constant/sizes.dart';
import 'package:uni_link/features/on_boarding/controller/on_boarding_controller.dart';
import 'package:uni_link/utils/helpers/helper_functions.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });
  final String image, title, subTitle;
  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Padding(
      padding: const EdgeInsets.all(OSizes.defaultSpace),
      child: Column(
        children: [
          Image(
              width: OHelperFunctions.screenWidth() * 0.8,
              height: OHelperFunctions.screenHeight() * 0.6,
              image: AssetImage(image)),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: OSizes.spaceBtwItems,
          ),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
