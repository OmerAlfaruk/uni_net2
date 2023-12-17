import 'package:flutter/material.dart';
import 'package:uni_link/constant/sizes.dart';
import 'login_footer.dart';
import 'login_form_widget.dart';
import 'login_header_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoginHeader(size: size),
                const LoginFormWidget(),
                const LoginFooter(),
          ]),
        ),
      )),
    );
  }
}


