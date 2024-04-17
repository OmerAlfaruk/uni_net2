import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/profile/presentation/pages/profile/widget/profile_form_widget.dart';
import 'package:uni_link/features/user/user_cubit/user/user_cubit.dart';
import 'package:uni_link/features/user/user_entity/user_entity.dart';

import 'package:uni_link/injection_container.dart' as di;

import '../../../../post/domain/use_cases/upload_image_to_storage_usecase.dart';

class EditProfilePage extends StatefulWidget {
  final UserEntity currentUser;

  const EditProfilePage({Key? key, required this.currentUser,}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController? _nameController;
  TextEditingController? _websiteController;
  TextEditingController? _bioController;
  TextEditingController? _universityController;
  TextEditingController? _departmentController;
  TextEditingController? _professionController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.currentUser.username);
    _websiteController = TextEditingController(text: widget.currentUser.website);
    _bioController = TextEditingController(text: widget.currentUser.bio);
    _universityController = TextEditingController(text: widget.currentUser.university);
    _departmentController = TextEditingController(text: widget.currentUser.department);
    _professionController = TextEditingController(text: '');

    super.initState();
  }




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
              onTap:
                _updateUserProfileData
                ,
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
              SizedBox(height: 15,),
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: profileWidget(imageUrl: widget.currentUser.profileUrl),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Center(
                child: GestureDetector(
                  onTap: selectImage,
                  child: const Text(
                    "Change profile photo",
                    style: TextStyle(color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              ProfileFormWidget(title: "Name", controller: _nameController),
              const SizedBox(height: 5,),
              ProfileFormWidget(
                  title: "Website", controller: _websiteController),
              const SizedBox(height: 5,),
              ProfileFormWidget(title: "University", controller: _universityController),
              const SizedBox(height: 5,),
              ProfileFormWidget(title: "Department", controller: _departmentController),
              const SizedBox(height: 5,),
              ProfileFormWidget(title: "Profession", controller: _professionController),
              const SizedBox(height: 5,),
              ProfileFormWidget(title: "bio", controller: _bioController),
              const SizedBox(height: 15,),
              _isUpdating == true?Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Please wait...", style: TextStyle(color: oPrimaryColor),),
                  sizeHor(10),
                  CircularProgressIndicator()
                ],
              ) : Container(width: 0, height: 0,)


            ],
          ),
        ),
      ),
    );
  }
  bool _isUpdating = false;

  File? _image;


  Future selectImage() async {
    try {
      final pickedFile = await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("no image has been selected");
        }
      });

    } catch(e) {
      toast("some error occured $e");
    }
  }

  _updateUserProfileData() {
    setState(() => _isUpdating = true);
    if (_image == null) {
      _updateUserProfile("");
    } else {
      di.sl<UploadImageToStorageUseCase>().call(_image!, false, "profileImages").then((profileUrl) {
        _updateUserProfile(profileUrl);
      });
    }
  }

  _updateUserProfile(String profileUrl) {

    BlocProvider.of<UserCubit>(context).updateUser(
        user: UserEntity(
            uid: widget.currentUser.uid,
            bio: _bioController!.text,
            website: _websiteController!.text,
            username: _nameController!.text,
            department: _departmentController!.text,
            privilege: _professionController!.text,
            university: _universityController!.text,
            profileUrl: profileUrl
        )
    ).then((value) => _clear());
  }

  _clear() {
    setState(() {
      _isUpdating = false;
      _bioController!.clear();
      _websiteController!.clear();
      _nameController!.clear();
      _universityController!.clear();
      _departmentController!.clear();
      _professionController!.clear();
    });
    Navigator.pop(context);
  }
}