
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_link/constant/sizes.dart';
import 'package:uni_link/constant/text_string.dart';
import 'package:uni_link/features/user/credential/presentation/pages/credential/sign_in_page.dart';
import 'package:uni_link/utils/helpers/helper_functions.dart';


class PasswordChange extends StatelessWidget {
  const PasswordChange({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: ()=>Get.offAll(const SignInPage()), icon: const Icon(CupertinoIcons.clear))
        ],),
      body: Padding(
        padding: const EdgeInsets.all(OSizes.defaultSpace),
        child:  Column(
          children: [
            /// Image

            const SizedBox(
              height: OSizes.spaceBtwItems,
            ),

            /// Title And Subtitles
            Text(
              'Change Your Password',
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
                onPressed: ()=>Get.offAll(const SignInPage()),
                child: const Text('Change'),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
