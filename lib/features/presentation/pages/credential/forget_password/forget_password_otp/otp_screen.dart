import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../constant/sizes.dart';
import '../../../../../../constant/text_string.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding:EdgeInsets.all(defaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(otpTitle,style: GoogleFonts.montserrat(
fontWeight: FontWeight.bold,
            fontSize: 80
          ),),
          Text(otpSubTitle.toUpperCase(),style: Theme.of(context).textTheme.titleLarge,),
          const SizedBox(height: 40.0,),
          const Text("flutter pub add flutter_otp_text_fieldomerKamil@gmail.com",textAlign: TextAlign.center,),
            const SizedBox(height: 20.0,),
          OtpTextField(
            numberOfFields: 6,
            fillColor: Colors.black.withOpacity(0.1),
            filled: true,
            onSubmit: (code){

             //OTPController.instance.verifyOTP(otp);

            },
          ),
            const SizedBox(height: 20.0,),
            SizedBox(width: double.infinity,
                child: ElevatedButton(onPressed: (){
                 // OTPController.instance.verifyOTP(otp);

                }, child:const Text('Next'))),

        ],),
      ),
    );
  }
}
