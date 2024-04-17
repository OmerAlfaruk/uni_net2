import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_link/constant/color.dart';

import 'package:uni_link/constant/const.dart';

import 'package:get/get.dart';
import 'package:uni_link/features/main/main_screen.dart';


import 'package:uni_link/features/presentation/widgets/button_container_widget.dart';
import 'package:uni_link/features/presentation/widgets/form_container_widget.dart';
import 'package:uni_link/features/user/auth/presentation/manager/auth/auth_cubit.dart';
import 'package:uni_link/features/user/credential/presentation/manager/credential/credential_cubit.dart';
import 'package:uni_link/features/user/credential/presentation/pages/password_configuration/forget_password.dart';





class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isSigningIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                    return MainScreen(uid: authState.uid);
                  } else {
                    return _bodyWidget();
                  }
                },
              );
            }
            return _bodyWidget();
          },
        ),
    );
  }

  _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),

          sizeVer(30),

          FormContainerWidget(
            controller: _emailController,
            hintText: "Email",
            prefixIcon: Icons.mail_rounded,
          ),
          sizeVer(10),
          FormContainerWidget(
            controller: _passwordController,
            hintText: "Password",
            isPasswordField: true,
            prefixIcon: Icons.security_outlined,
          ),
          sizeVer(15),
          ButtonContainerWidget(

            text: "Sign In",
            onTapListener: () {
              _signInUser();
            },
          ),
          sizeVer(10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            sizeHor(50),TextButton(onPressed: (){Get.to(()=>ForgetPassword());}, child: Text('Forget Password'))
          ],),

          _isSigningIn == true ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Please wait", style: TextStyle(color: oPrimaryColor, fontSize: 16, fontWeight: FontWeight.w400),),
              sizeHor(10),
              CircularProgressIndicator()
            ],
          ) : Container(width: 0, height: 0,),
          Flexible(
            child: Container(),
            flex: 2,
          ),
          Divider(
            color: oSecondaryColor,
          ),


  ]
      ),
    );
  }

  void _signInUser() {
    setState(() {
      _isSigningIn = true;
    });
    BlocProvider.of<CredentialCubit>(context).signInUser(
      email: _emailController.text,
      password: _passwordController.text,
    ).then((value) => _clear());
  }

  _clear() {
    setState(() {
      _emailController.clear();
      _passwordController.clear();
      _isSigningIn = false;
    });
  }
}
