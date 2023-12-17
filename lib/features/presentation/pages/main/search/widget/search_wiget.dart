import 'package:flutter/material.dart';
import 'package:uni_link/constant/color.dart';



class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  const SearchWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: oPrimaryColor),
        decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: oPrimaryColor,),
            hintText: "Search",
        ),
      ),
    )
    ;
  }
}
