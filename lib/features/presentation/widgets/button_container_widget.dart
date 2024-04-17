
import 'package:flutter/material.dart';
import 'package:uni_link/constant/color.dart';



class ButtonContainerWidget extends StatelessWidget {
  final Color? color;
  final String? text;
  final VoidCallback? onTapListener;
  const ButtonContainerWidget({Key? key, this.color, this.text, this.onTapListener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTapListener,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3)
        ),
        child: Center(child: Text("$text", style: TextStyle(color: oPrimaryColor, fontWeight:FontWeight.w600),),),
      ),
    );
  }
}
