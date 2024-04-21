import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_link/constant/sizes.dart';
import 'package:uni_link/features/password_configuration/controller/reset_password_controller.dart';
import 'package:uni_link/features/user/presentation/pages/login/sign_in_page.dart';

import '../../../../utils/helpers/helper_functions.dart';

class ResetPassword extends StatelessWidget {
  final String email;
  const ResetPassword({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(const SignInPage()),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(OSizes.defaultSpace),
        child: Column(
          children: [
            Text(
              email,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: OSizes.spaceBtwItems,
            ),

            /// Title And Subtitles
            Text(
              "Recieve Email to change Your Password",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),

            const SizedBox(
              height: OSizes.spaceBtwSections,
            ),

            /// Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.offAll(const SignInPage()),
                child: const Text('Done'),
              ),
            ),
            const SizedBox(
              height: OSizes.spaceBtwItems,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => ForgetPasswordController.instance
                    .resendPasswordResetEmail(email),
                child: const Text('Resend Email'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
