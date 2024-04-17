import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/presentation/widgets/button_container_widget.dart';
import 'package:uni_link/features/presentation/widgets/form_container_widget.dart';
import 'package:uni_link/features/user/auth/presentation/manager/auth/auth_cubit.dart';
import 'package:uni_link/features/user/credential/presentation/manager/credential/credential_cubit.dart';
import 'package:uni_link/features/user/credential/presentation/pages/credential/sign_in_page.dart';
import 'package:uni_link/features/user/user_entity/user_entity.dart';
import 'package:uni_link/utils/popups/loaders.dart';

import '../../../../utils/validators/validator.dart';
import '../../../user/credential/presentation/widgets/terms and condition.dart';
import '../../../user/credential/presentation/widgets/widget_controller/terms_and_condition_conroller.dart';


class AddSingleUserPage extends StatefulWidget {
  const AddSingleUserPage({Key? key}) : super(key: key);

  @override
  State<AddSingleUserPage> createState() => _AddSingleUserPageState();
}
GlobalKey<FormState> signupFormKey=GlobalKey<FormState>();


class _AddSingleUserPageState extends State<AddSingleUserPage> {
  final PrivacyController=TermsAndConditionController.instance;
  String dropdownvalue = 'Arbaminch University';

  var items = [
    'Adama Science and Technology University',
    'Addis Ababa Science and Technology University',
    'Addis Ababa University',
    'Adigrat University',
    'Ambo University',
    'Arbaminch University',
    'Arsi University',
    'Assosa University',
    'Axum University',
    'Bahir Dar University',
    'Bonga University',
    'Borana University',
    'Bule Hora University',
    'Dambi Dollo University',
    'Debark University',
    'Debre Berhan University',
    'Debre Markos University',
    'Debre Tabor University',
    'Defence University',
    'Dilla University',
    'Dire Dawa University',
    'Ethiopian Civil Service University',
    'Ethiopian Police University College',
    'Gambella University',
    'Haramaya University',
    'Hawassa University',
    'Injibara University',
    'Jijiga University',
    'Jimma University',
    'Jinka University',
    'Kebri Dehar University',
    'Kotebe Metropolitan University',
    'Meda Walabu University',
    'Mekdela Amba University',
    'Mekelle University',
    'Mettu University',
    'Mizan Tepi University',
    'Oda Bultum University',
    'Oromia State University',
    'Raya University',
    'Salale University',
    'Semera University',
    'University of Gondar',
    'Wachamo University',
    'Werabe University',
    'Wolaita Sodo University',
    'Woldia University',
    'Wolkite University',
    'Wollega University',
    'Wollo University'
  ];
  String _selectedItem = 'User';
  List<String> _dropdownItems = ['User','Communicator','Faculty Representative'];

  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  bool _isSigningUp = false;
  bool _isUploading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  File? _image;

  Future selectImage() async {
    try {
      final pickedFile =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("no image has been selected");
        }
      });
    } catch (e) {
      toast("some error occured $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Single User',style:TextStyle(color: oPrimaryColor)),),
        body: BlocConsumer<CredentialCubit, CredentialState>(
      listener: (context, credentialState) {
        if (credentialState is CredentialSuccess) {
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }
        if (credentialState is CredentialFailure) {
          toast("Invalid Email and Password");
        }
      },
      builder: (context, credentialState) {
        if (credentialState is CredentialSuccess) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is Authenticated) {
                Loader.successSnackBar(title: "User created successfully");
              } else {
                return _bodyWidget();
              }
              return _bodyWidget();
            },
          );
        }
        return _bodyWidget();
      },
    ));
  }

  _bodyWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height:200,
                ),

                Form(
                  key: signupFormKey,

                  child: Column(
                    children: [
                      FormContainerWidget(
                        validator: (value)=>OValidator.validateEmptyText('Full Name', value),
                        controller: _usernameController,
                        hintText: "Full Name",
                        prefixIcon: Icons.account_circle,
                      ),
                      sizeVer(15),
                      FormContainerWidget(
                        validator: (value)=>OValidator.validateEmail(value),
                        controller: _emailController,
                        hintText: "Email",
                        prefixIcon: Icons.mail_rounded,
                      ),
                      sizeVer(15),
                      FormContainerWidget(
                        validator: (value)=>OValidator.validatePassword(value),
                        controller: _passwordController,
                        hintText: "Password",
                        isPasswordField: true,
                        prefixIcon: Icons.security_outlined,
                      ),
                      sizeVer(15),
                    ],
                  ),

                ),

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                   labelText: 'University',
                    border: OutlineInputBorder(

                    )

                  ),
                  value: dropdownvalue,
                  items: items.map<DropdownMenuItem<String>>((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),

                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
                sizeVer(15),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      labelText: 'Privilage',
                    labelStyle: TextStyle(color: oPrimaryColor)
                  ),
                  value: _selectedItem,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedItem = newValue!;
                    });
                  },
                  items: _dropdownItems.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),),
                sizeVer(10),
               // TermsAndConditions(),
                sizeVer(15),
                ButtonContainerWidget(
                  text: "Add User",
                  onTapListener: () {
                    if(signupFormKey.currentState!.validate()){
                      if(!PrivacyController.privacyPoly.value){
                        Loader.warningSnackBar(title: "You have to accept privacy policy");
                        return;
                      }
                    _signUpUser();}
                  },
                ),
              ],
            ),
            SizedBox(height: 170,),
            Column(

              children: [
                Divider(
                  color: oSecondaryColor,
                ),
                if(_isSigningUp)
                    Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Please wait",
                      style: TextStyle(
                          color: oPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    sizeHor(10),
                    CircularProgressIndicator()
                  ],
                )

              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _signUpUser() async {

    setState(() {
      _isSigningUp = true;
    });
    BlocProvider.of<CredentialCubit>(context)
        .signUpUser(
          user: UserEntity(
              email: _emailController.text,
              password: _passwordController.text,
              bio: '',
              isOnline: false,
              username: _usernameController.text,
              connections: [],
              totalConnection: 0,
              totalPosts: 0,
              university: dropdownvalue,
              website: "",
              department: '',
              privilege: _selectedItem,
              imageFile: _image),
        )
        .then((value) => _clear());
  }

  _clear() {
    setState(() {
      _usernameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _isSigningUp = false;
    });
  }

}

