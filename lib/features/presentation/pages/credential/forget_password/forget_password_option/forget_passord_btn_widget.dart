import 'package:flutter/material.dart';

class ForgetPasswordBtnWidget extends StatelessWidget {
  const ForgetPasswordBtnWidget({
    super.key, required this.title, required this.subTitle, required this.icon, required this.onTap,
  });
  final String title,subTitle;
  final IconData icon;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200
        ),
        child:  Row(children: [
          Icon(icon,size: 60,),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: Theme.of(context).textTheme.titleLarge,),
              Text(subTitle,style: Theme.of(context).textTheme.bodyMedium,),
            ],)
        ],),
      ),
    );
  }
}
