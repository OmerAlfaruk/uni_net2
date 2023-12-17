import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_link/constant/sizes.dart';
import 'package:uni_link/constant/text_string.dart';

import '../forget_password/forget_password_otp/otp_screen.dart';


class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormState>();
    return Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: formHeight - 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(

                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: fullName,
                  hintText: fullName,
                ),
              ),
              const SizedBox(
                height: formHeight - 10,
              ),
              TextFormField(

                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: email,
                  hintText: email,
                ),
              ),
              const SizedBox(
                height: formHeight - 10,
              ),
              TextFormField(

                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.fingerprint),
                    labelText: password,
                    hintText: password,
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove_red_eye))),
              ),
              const SizedBox(
                height: formHeight - 10,
              ),
              TextFormField(

                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.numbers),
                  labelText: "University",
                  hintText:"University",
                ),
              ),


              const SizedBox(
                height: formHeight - 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        //SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
                        //SignUpController.instance.phoneAuthentication(controller.phoneNumber.text.trim());

                       // Get.to(() => const OtpScreen());
                      }
                    },
                    child: const Text(signUp)),
              ),
            ],
          ),
        ));
  }
}
