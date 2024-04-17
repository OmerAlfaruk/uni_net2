
import 'package:flutter/material.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/utils/helpers/helper_functions.dart';

import '../../../../../../utils/device/device_utility.dart';
class OTabBar extends StatelessWidget implements PreferredSizeWidget{
  const OTabBar({super.key, required this.tabs});
  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    final dark=OHelperFunctions.isDark(context);
    return  Material(
      color: dark? blackColor:whiteColor,
      child: TabBar(tabs: tabs,
        isScrollable: true,
        indicatorColor: oPrimaryColor,
        labelColor: dark?Colors.white:oPrimaryColor,
        unselectedLabelColor: Colors.grey,

      ),
    );
  }

  @override

  Size get preferredSize => Size.fromHeight(ODeviceUtils.getAppBarHeight());
}