import 'package:flutter/material.dart';
import 'package:uni_link/constant/sizes.dart';
import 'package:uni_link/features/on_boarding/controller/on_boarding_controller.dart';
import 'package:uni_link/utils/device/device_utility.dart';

class Skip extends StatelessWidget {
  const Skip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: ODeviceUtils.getAppBarHeight(),
      right: OSizes.defaultSpace,
      child: TextButton(
        onPressed: () {
          OnBoardingController.instance.skipPage();
        },
        child: const Text('Skip'),
      ),
    );
  }
}
