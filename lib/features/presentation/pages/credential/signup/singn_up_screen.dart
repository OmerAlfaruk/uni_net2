import 'package:flutter/material.dart';
import 'package:uni_link/features/presentation/pages/credential/signup/sign_up_footer_widget.dart';
import 'package:uni_link/features/presentation/pages/credential/signup/sign_up_form_widget.dart';
import 'package:uni_link/common_widget/form_header/form_heade.dart';
import 'package:uni_link/constant/image_string.dart';
import 'package:uni_link/constant/sizes.dart';
import 'package:uni_link/constant/text_string.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          padding:  const EdgeInsets.all(defaultSize),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormHeader(
                image: appLogo,
                title: signUpScreenTitle,
                subTitle: signUpScreenSubTitle,
                screenRatio: 0.15,
              ),
              SignUpFormWidget(),
              SignUpFooter()
            ],
          ),
        ),
      )),
    );
  }
}
