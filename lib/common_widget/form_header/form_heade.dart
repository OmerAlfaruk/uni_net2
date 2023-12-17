

import 'package:flutter/material.dart';
import 'package:uni_link/constant/sizes.dart';



class FormHeader extends StatelessWidget {


  const FormHeader({
    super.key,
     required this.image, required this.title, required this.subTitle, required this.screenRatio, this.align,
  });
  final String image,title,subTitle;
  final num  screenRatio;
  final TextAlign? align;



  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Column(
      children: [
        Align(alignment: Alignment.center,child: Image(image:  AssetImage(image),height: size.height*screenRatio,)),
        const SizedBox(height: defaultSize,),
        Text(title ,style: Theme.of(context).textTheme.displaySmall,textAlign: align,),
        Text(subTitle,style:Theme.of(context).textTheme.bodyLarge ,textAlign: align,),
      ],
    );
  }
}