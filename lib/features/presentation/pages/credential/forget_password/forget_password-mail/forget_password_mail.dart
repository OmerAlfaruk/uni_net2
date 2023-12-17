import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common_widget/form_header/form_heade.dart';
import '../../../../../../constant/image_string.dart';
import '../../../../../../constant/sizes.dart';
import '../../../../../../constant/text_string.dart';
import '../forget_password_otp/otp_screen.dart';

class ForgetPasswordMail extends StatelessWidget {
  const ForgetPasswordMail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child:   Column(
            children: [
              const SizedBox(height: defaultSize*4,),
              const FormHeader(
                align: TextAlign.center,
                image: forgetPasswordImage,
                title: forgetPassword1,
                subTitle: forgetEmailSubTitle,
                screenRatio: 0.2,
              ),
              const SizedBox(height: formHeight,),
              Form(child: Column(
                children: [
                  TextFormField(
                    decoration:  const InputDecoration(
                        labelText: email,
                        hintText: email,
                        border: OutlineInputBorder()),
                  ),
                ],
              ),),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(width: double.infinity,
                  child: ElevatedButton(onPressed: (){
                    Get.to(const OtpScreen());
                  }, child: const Text('Next'))),

            ],
          ),
        ),
      ),
    );
  }
}
