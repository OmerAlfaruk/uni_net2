import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/features/presentation/pages/app/settings/widgets/settings_menu.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: oPrimaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SettingsMenuTile(
                icon: Iconsax.location,
                title: 'Location',
                trailing: Switch(value: false,onChanged: (value){},),
                onTap: () {}, subTitle: '',
              ),SettingsMenuTile(
                icon: Iconsax.moon,
                title: 'Dark theme',
                trailing: Switch(value: false,onChanged: (value){},),
                onTap: () {}, subTitle: '',
              ),SettingsMenuTile(
                icon: Iconsax.image,
                title: 'Load Data',
                subTitle: '',
                trailing: Switch(value: false,onChanged: (value){},),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),

    );
  }
}
