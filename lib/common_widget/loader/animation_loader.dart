
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uni_link/constant/color.dart';

/// A sub_widget for displaying an animation loading indicator with optional text and action button
class AnimationLoaderWidget extends StatelessWidget {

  /// parameters
  /// - text: the text to be displayed below the animation
  /// - animation: the path to the lottie animation file
  /// - showAction: whether to show action button.
  /// - ActionText: The text to be displayed on the action Button
  /// - onActionPressed: callBack function to be executed when action button is pressed
  const AnimationLoaderWidget(
      {super.key,
      required this.text,
      required this.animation,
       this.showAction=false,
      this.onActionPressed,this.actionText});
  final String text;
  final String animation;
  final bool showAction;
 final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Lottie.asset(animation,width: MediaQuery.of(context).size.width *0.8),
        const SizedBox(height: 26,),
        Text(text,style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center,),
        const SizedBox(height: 26,),
        showAction?SizedBox(
          width: 250,
          child: OutlinedButton(onPressed: onActionPressed,
            style: OutlinedButton.styleFrom(backgroundColor: oDarkColor),
            child: Text(actionText!,style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),),

          ),
        ):const SizedBox(),


      ],),
    );
  }


}
