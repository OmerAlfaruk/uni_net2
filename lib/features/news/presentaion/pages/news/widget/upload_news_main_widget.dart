import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/news/domain/entities/news_entity.dart';

import 'package:uni_link/features/news/domain/use_cases/upload_image_to_storage_usecase.dart';
import 'package:uni_link/features/news/domain/entities/news_entity.dart';
import 'package:uni_link/features/news/presentaion/managers/news/news_cubit.dart';
import 'package:uni_link/features/profile/presentation/pages/profile/widget/profile_form_widget.dart';
import 'package:uni_link/features/user/user_entity/user_entity.dart';
import 'package:uuid/uuid.dart';
import 'package:uni_link/injection_container.dart' as di;



class UploadNewsMainWidget extends StatefulWidget {
  final UserEntity currentUser;
  const UploadNewsMainWidget({super.key, required this.currentUser});

  @override
  State<UploadNewsMainWidget> createState() => _UploadNewsMainWidget();
}

class _UploadNewsMainWidget extends State<UploadNewsMainWidget> {
  File? _image;
  TextEditingController _descriptionController = TextEditingController();
  bool _uploading = false;
  String _selectedItem = 'News';
  List<String> _dropdownItems = ['post','News']
  ;String _selectedItem2 = 'News';
  List<String> _dropdownItems2 = ['post','Announcements'];


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
    return _image == null? _uploadNewsWidget() : Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap: () => setState(() => _image = null),child: Icon(Icons.close, size: 28,)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(onTap: _submitNews,child: Icon(Icons.arrow_forward)),
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

  _submitNews() {
    setState(() {
      _uploading = true;
    });
    di.sl<UploadImageToStorageUseCase1>().call(_image!, true, "news").then((imageUrl) {
      _createSubmitNews(image: imageUrl);
    });
  }

  _createSubmitNews({required String image}) {
    BlocProvider.of<NewsCubit>(context).createNews(
        news: NewsEntity(
            description: _descriptionController.text,
            createAt: Timestamp.now(),
            newsType:"",
            creatorUid: widget.currentUser.uid,
            likes: [],
            newsId: Uuid().v1(),
            newsImageUrl: image,
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

  _uploadNewsWidget() {
    return Scaffold(
        body: Column(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("What is new about your university?",style: Theme.of(context).textTheme.titleLarge!.apply(color: oPrimaryColor),),
            SizedBox(height: 70,),
            SizedBox(height: 70,),widget.currentUser.privilege=="Faculty Representative"?Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('choose News Type : '),
                sizeHor(10),
                DropdownButton<String>(
                  value: _selectedItem2,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedItem2 = newValue!;
                    });
                  },
                  items: _dropdownItems2.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ):SizedBox(height: 70,),
            
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
