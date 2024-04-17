import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_link/constant/color.dart';

import 'add_single_user.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add User',style: TextStyle(color: oPrimaryColor),),),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: (){
                Get.to(()=>AddSingleUserPage());
              },
              child: Container(

                child: Text('Add Single User'),
              ),
            ),
            ElevatedButton(
              onPressed: (){},
              child: Container(

                child: Text('Add Multiple User'),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
