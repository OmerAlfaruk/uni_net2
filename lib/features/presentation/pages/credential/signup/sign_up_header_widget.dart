import 'package:flutter/material.dart';
import 'package:uni_link/constant/image_string.dart';
import 'package:uni_link/constant/text_string.dart';


class SignUpHeader extends StatelessWidget {
  const SignUpHeader({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: const AssetImage('assets/images/logo/applogo.png'),height: size.height*0.15,),
        Text(signUpScreenTitle ,style: Theme.of(context).textTheme.displaySmall,),
        Text(signUpScreenSubTitle,style:Theme.of(context).textTheme.bodyLarge ,),
      ],
    );
  }
}