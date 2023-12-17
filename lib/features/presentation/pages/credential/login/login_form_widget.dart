import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import 'package:uni_link/constant/sizes.dart';
import 'package:uni_link/constant/text_string.dart';
import 'package:uni_link/features/presentation/pages/main/main_screen.dart';




import '../forget_password/forget_password_option/build_show_bottom_sheet.dart';


class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: formHeight - 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: email,
                hintText: email,
                border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: formHeight,
          ),
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint),
                labelText: password,
                hintText: password,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.remove_red_eye))),
          ),
          const SizedBox(
            height: formHeight - 20,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    ShowBottomSheetWidget.buildShowModalBottomSheet(context);
                  }, child: const Text(forgetPassword))),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: () {
             Get.to(const MainScreen());
            }, child: const Text(login)),
          ),
        ],
      ),
    ));
  }


}

