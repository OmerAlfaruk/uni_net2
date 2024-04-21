import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/features/admin/user%20management/presentation/add_user.dart';

class UserManagement extends StatefulWidget {
  const UserManagement({super.key});

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Management',style: TextStyle(color: oPrimaryColor),),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            ElevatedButton(onPressed: (){ Get.to(()=>AddUserPage());}, child: Text('Add User'),),
            ElevatedButton(onPressed: (){}, child: Text('Update User'),),
            ElevatedButton(onPressed: (){}, child: Text('Delete User'),),
          ],
        ),
      ),
    );
  }
}
