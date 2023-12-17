import 'package:flutter/material.dart';
import 'package:uni_link/constant/image_string.dart';
import 'package:uni_link/constant/text_string.dart';


class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(alignment: Alignment.center,child: Image(image: const AssetImage(appLogo),height: size.height*0.2,)),
        Text(loginScreenTitle ,style: Theme.of(context).textTheme.displaySmall,),
        Text(loginScreenSubTitle,style:Theme.of(context).textTheme.bodyLarge ,),
      ],
    );
  }
}