
import 'package:flutter/material.dart';



class OGridLayout extends StatelessWidget {
  const OGridLayout({
    super.key,
    required this.itemCount,
    this.mainAxisExtent = 250,
    required this.itemBuilder,
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: itemCount,
        padding: EdgeInsets.zero,

        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            mainAxisExtent: mainAxisExtent),
        itemBuilder: itemBuilder);
  }
}