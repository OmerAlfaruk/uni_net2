import 'package:flutter/material.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/features/profile/presentation/pages/profile/widget/profile_form_widget.dart';


class EditPostPage extends StatefulWidget {
  const EditPostPage({super.key});

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(

      appBar: AppBar(
        title: const Text("Edit Post",style: TextStyle(color: oPrimaryColor),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(onTap:(){},child: const Icon(Icons.done,color: oPrimaryColor,),),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: profileWidget(),
                ),
              ),
              const SizedBox(height: 10),
              const Text("username", style: TextStyle(color: oPrimaryColor, fontSize: 16, fontWeight: FontWeight.bold),),
              const SizedBox(height: 10),
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: profileWidget(

                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: GestureDetector(
                      onTap: (){},
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: const Icon(Icons.edit, color: Colors.blue,),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const ProfileFormWidget(
                title: "Description",
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Updating...", style: TextStyle(color: oPrimaryColor),),
            SizedBox(width: 10),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
