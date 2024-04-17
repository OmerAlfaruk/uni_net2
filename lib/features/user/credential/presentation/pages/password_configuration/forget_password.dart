
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uni_link/constant/sizes.dart';
import 'package:uni_link/constant/text_string.dart';
import 'package:uni_link/features/user/credential/presentation/pages/password_configuration/reset_password.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(OSizes.defaultSpace),
        child: Column(children: [
          ///Heading
          Text(forgetPasswordTitle,style: Theme.of(context).textTheme.headlineMedium,),
          const SizedBox(height: OSizes.defaultSpace,),
          Text(forgetPasswordSubTitle,style: Theme.of(context).textTheme.labelMedium,),
          const SizedBox(height: OSizes.spaceBtwSections+2,),
          ///Text Field
          TextFormField(
            decoration: const InputDecoration(
              labelText: email,prefixIcon: Icon(Iconsax.direct_right),
            ),
          ),
          const SizedBox(height: OSizes.spaceBtwSections+2,),
          ///submit button
          SizedBox(width:double.infinity,child: ElevatedButton(onPressed: (){Get.to(()=>const ResetPassword());}
              , child:const Text("Submit") )),

        ],),
      ),
    );
  }
}
