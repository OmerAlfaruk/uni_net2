import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uni_link/constant/sizes.dart';
import 'package:uni_link/constant/text_string.dart';
import 'package:uni_link/features/password_configuration/controller/reset_password_controller.dart';
import 'package:uni_link/utils/validators/validator.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(OSizes.defaultSpace),
        child: Column(
          children: [
            ///Heading
            Text(
              forgetPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: OSizes.defaultSpace,
            ),
            Text(
              forgetPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: OSizes.spaceBtwSections + 2,
            ),

            ///Text Field
            Form(
              key: controller.forgetPasswordKey,
              child: TextFormField(
                controller: controller.email,
                validator: OValidator.validateEmail,
                decoration: const InputDecoration(
                  labelText: email,
                  prefixIcon: Icon(Iconsax.direct_right),
                ),
              ),
            ),
            const SizedBox(
              height: OSizes.spaceBtwSections + 2,
            ),

            ///submit button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.sendPasswordResetEmail(),
                    child: const Text("Submit"))),
          ],
        ),
      ),
    );
  }
}
