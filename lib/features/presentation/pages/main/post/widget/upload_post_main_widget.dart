import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/domain/entities/post/post_entity.dart';
import 'package:uni_link/features/domain/entities/user/user_entity.dart';
import 'package:uni_link/features/domain/use_cases/storage/upload_image_to_storage_use_case.dart';
import 'package:uni_link/features/presentation/cubit/post/post_cubit.dart';
import 'package:uni_link/features/presentation/pages/main/profile/widget/profile_form_widget.dart';
import 'package:uuid/uuid.dart';
import 'package:uni_link/injection_container.dart' as di;

class UploadPostMainWidget extends StatefulWidget {
  final UserEntity currentUser;
  const UploadPostMainWidget({super.key, required this.currentUser});

  @override
  State<UploadPostMainWidget> createState() => _UploadPostMainWidget();
}

class _UploadPostMainWidget extends State<UploadPostMainWidget> {
  File? _image;
  TextEditingController _descriptionController = TextEditingController();
  bool _uploading = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return _image == null? _uploadPostWidget() : Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap: () => setState(() => _image = null),child: Icon(Icons.close, size: 28,)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(onTap: _submitPost,child: Icon(Icons.arrow_forward)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(

          children: [

            Container(
              width: 80,
              height: 80,
              child: ClipRRect(borderRadius: BorderRadius.circular(40),child: profileWidget(imageUrl: "${widget.currentUser.profileUrl}")),
            ),
            sizeVer(10),
            Text("${widget.currentUser.username}", style: TextStyle(color: Colors.white),),
            sizeVer(10),
            Container(
              width: double.infinity,
              height: 200,
              child: profileWidget(image: _image),
            ),
            sizeVer(10),
            ProfileFormWidget(title: "Description", controller: _descriptionController,),
            sizeVer(10),
            _uploading == true?Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Uploading...", style: TextStyle(color: Colors.white),),
                sizeHor(10),
                CircularProgressIndicator()
              ],
            ) : Container(width: 0, height: 0,)
          ],
        ),
      ),
    );
  }

  _submitPost() {
    setState(() {
      _uploading = true;
    });
    di.sl<UploadImageToStorageUseCase>().call(_image!, true, "posts").then((imageUrl) {
      _createSubmitPost(image: imageUrl);
    });
  }

  _createSubmitPost({required String image}) {
    BlocProvider.of<PostCubit>(context).createPost(
        post: PostEntity(
            description: _descriptionController.text,
            createAt: Timestamp.now(),
            creatorUid: widget.currentUser.uid,
            likes: [],
            postId: Uuid().v1(),
            postImageUrl: image,
            totalComments: 0,
            totalLikes: 0,
            username: widget.currentUser.username,
            userProfileUrl: widget.currentUser.profileUrl
        )
    ).then((value) => _clear());
  }

  _clear() {
    setState(() {
      _uploading = false;
      _descriptionController.clear();
      _image = null;
    });
  }

  _uploadPostWidget() {
    return Scaffold(

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("What is new about your university?",style: Theme.of(context).textTheme.titleLarge!.apply(color: oPrimaryColor),),
            SizedBox(height: 70,),
            Center(
              child: GestureDetector(
                onTap: selectImage,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      color: oSecondaryColor.withOpacity(.3),
                      shape: BoxShape.circle
                  ),
                  child: Center(
                    child: Icon(Icons.upload, color: oPrimaryColor, size: 40,),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
