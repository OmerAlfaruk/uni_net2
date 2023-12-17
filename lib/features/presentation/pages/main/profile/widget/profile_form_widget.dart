import 'package:flutter/material.dart';
import 'package:uni_link/constant/color.dart';

class ProfileFormWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  const ProfileFormWidget({Key? key, this.title, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title", style: TextStyle(color: oPrimaryColor, fontSize: 16),),
        SizedBox(height: 5,),
        TextFormField(
          controller: controller,
          style: const TextStyle(color: oPrimaryColor),
          decoration: const InputDecoration(
              border: InputBorder.none,
              labelStyle: TextStyle(color: oPrimaryColor)
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey,
        )
      ],
    );
  }
}