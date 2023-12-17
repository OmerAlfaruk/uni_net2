import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uni_link/constant/image_string.dart';
import 'package:uni_link/constant/sizes.dart';
import 'package:uni_link/constant/text_string.dart';
import 'package:uni_link/features/presentation/pages/credential/signup/singn_up_screen.dart';



class LoginFooter extends StatelessWidget {
  const LoginFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("or"),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Image(
              image: AssetImage(googleLogo),
              width: 20,

            ),
            label: const Text(signUpWithGoogle),
          ),),
        const SizedBox(height: formHeight-20,),
        TextButton(onPressed: (){
          Get.to(const SignUpScreen());
        }, child: Text.rich(TextSpan(
            text: dontHaveAnAccount,
            style: Theme.of(context).textTheme.bodyLarge,
            children: [

              TextSpan(
                  text: signUp.toLowerCase(),
                  style: const TextStyle(color: Colors.blue,)

              )
            ]
        )),
        )
      ],
    );
  }
}