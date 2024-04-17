
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/features/user/credential/presentation/widgets/widget_controller/terms_and_condition_conroller.dart';
import 'package:uni_link/utils/helpers/helper_functions.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    final controller=TermsAndConditionController.instance;
    final dark=OHelperFunctions.isDark(context);
    return Row(
      children: [
        Obx(
        ()=> SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: controller.privacyPoly.value,
              onChanged: (value) {
                controller.privacyPoly.value=!controller.privacyPoly.value;
              },
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: 'I agree to ',
                    style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                  text: 'Privacy Policy',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(
                      color: dark
                          ? oWhiteColor
                          : oPrimaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: dark
                          ? oWhiteColor
                          : oPrimaryColor,),
                ),
                TextSpan(
                    text: ' and ',
                    style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                  text: 'Terms of use',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(
                      color: dark
                          ? oWhiteColor
                          : oPrimaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: dark
                      ? oWhiteColor
                    : oPrimaryColor,),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}