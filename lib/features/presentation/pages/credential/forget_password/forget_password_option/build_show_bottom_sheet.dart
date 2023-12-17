import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../../../../../../constant/sizes.dart';
import '../../../../../../constant/text_string.dart';
import '../forget_password-mail/forget_password_mail.dart';
import 'forget_passord_btn_widget.dart';



class ShowBottomSheetWidget{
 static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context, builder: (context)=>Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(forgetPasswordTitle,style: Theme.of(context).textTheme.displaySmall,),
              Text(forgetPasswordSubTitle,style: Theme.of(context).textTheme.bodyMedium,),
              const SizedBox(height: 30,),
              ForgetPasswordBtnWidget(title: email, subTitle: resetViaEmail, icon: Icons.mail_outline_outlined, onTap: () { Get.to(const ForgetPasswordMail()); },),
              const SizedBox(height: 20.0,),
              ForgetPasswordBtnWidget(title: phoneNumber, subTitle: resetViaPhone, icon: Icons.mobile_friendly_outlined, onTap: () {  },)
            ],),
        ));
  }
}