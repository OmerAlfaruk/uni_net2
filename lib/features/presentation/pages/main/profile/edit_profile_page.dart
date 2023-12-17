import 'package:flutter/material.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/features/presentation/pages/main/profile/widget/profile_form_widget.dart';

class EditProfilePage extends StatefulWidget {

  const EditProfilePage({Key? key,}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController? _nameController;
  TextEditingController? _usernameController;
  TextEditingController? _websiteController;
  TextEditingController? _bioController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _usernameController =
        TextEditingController();
    _websiteController =
        TextEditingController();
    _bioController = TextEditingController();
    super.initState();
  }

  bool _isUpdating = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Edit Profile", style: Theme
            .of(context)
            .textTheme
            .bodyMedium,),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.close,
              size: 32,
              color: Colors.grey,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: (){},
              child: const Icon(
                Icons.done,
                color: Colors.blue,
                size: 32,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: profileWidget(),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Change profile photo",
                    style: TextStyle(color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              ProfileFormWidget(title: "Name", controller: _nameController),
              SizedBox(height: 10,),
              ProfileFormWidget(
                  title: "Username", controller: _usernameController),
              SizedBox(height: 5,),
              ProfileFormWidget(
                  title: "Website", controller: _websiteController),
              SizedBox(height: 5,),
              ProfileFormWidget(title: "Bio", controller: _bioController),
              SizedBox(height: 5,),
              ProfileFormWidget(title: "Bio", controller: _bioController),
              SizedBox(height: 5,),
              ProfileFormWidget(title: "Bio", controller: _bioController),
              SizedBox(height: 5,),
              ProfileFormWidget(title: "Bio", controller: _bioController),
              SizedBox(height: 5,),
            ],
          ),
        ),
      ),
    );
  }
}