import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uni_link/features/user/presentation/manager/auth/auth_cubit.dart';
import 'package:uni_link/features/user/presentation/pages/login/sign_in_page.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  static const routeName = '/settings-screen';
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,

        title: Text(
          'Settings',
          style: GoogleFonts.raleway(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: GestureDetector(
          child: const Icon(
              Iconsax.close_square,
          ),
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (_, state) {
          if (state is UnAuthenticated) {
            Get.offAll(()=>SignInPage());

          }
        },
        builder: (BuildContext context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 30, 16, 0),
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(
                      maxWidth: 470,
                    ),
                    decoration: const BoxDecoration(),
                    child: Column(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: InkWell(
                            onTap: () {},
                            child: SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const Align(
                                          alignment:
                                          AlignmentDirectional.centerStart,
                                          child: Icon(
                                            Iconsax.password_check,
                                            color: Colors.blueGrey,
                                            size: 30,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 20),
                                          child: Text(
                                            'Change Password',
                                            style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,

                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: InkWell(
                            onTap: () {},
                            child: SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const Align(
                                          alignment:
                                          AlignmentDirectional.centerStart,
                                          child: Icon(
                                            Iconsax.shield_tick,
                                            color: Colors.blueGrey,
                                            size: 30,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 20),
                                          child: Text(
                                            'Privacy and Security',
                                            style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,

                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: InkWell(
                            onTap: () {},
                            child: SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const Align(
                                          alignment:
                                          AlignmentDirectional.centerStart,
                                          child: Icon(
                                            Iconsax.notification,
                                            color: Colors.blueGrey,
                                            size: 30,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 20),
                                          child: Text(
                                            'Notification Settings',
                                            style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,

                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: InkWell(

                            child: SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const Align(
                                          alignment:
                                          AlignmentDirectional.centerStart,
                                          child: Icon(
                                            Iconsax.eye,
                                            color: Colors.blueGrey,
                                            size: 30,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 20),
                                          child: Text(
                                            'Change Appearance',
                                            style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,

                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment:
                                            AlignmentDirectional.centerEnd,
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                              Colors.transparent,

                                              child: Container(
                                                width: 70,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      blurRadius: 3,
                                                      color: Color(0x33000000),
                                                      offset: Offset(0, 1),
                                                    )
                                                  ],
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                ),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(2, 2, 2, 2),
                                                  child: Stack(
                                                    alignment:
                                                    AlignmentDirectional
                                                        .center,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                        const AlignmentDirectional(
                                                            -0.90, 0),
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              6, 0, 0, 0),
                                                          child: Icon(
                                                            Iconsax
                                                                .shield_tick,
                                                            size: 24,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                        AlignmentDirectional
                                                            .centerEnd,
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0, 0, 6, 0),
                                                          child: Icon(
                                                            Iconsax.danger,
                                                            size: 24,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                        AlignmentDirectional
                                                            .centerEnd,
                                                        child: Container(
                                                          width: 36,
                                                          height: 36,
                                                          decoration:
                                                          BoxDecoration(

                                                            boxShadow: const [
                                                              BoxShadow(
                                                                blurRadius: 4,
                                                                color: Color(
                                                                    0x430B0D0F),
                                                                offset: Offset(
                                                                    0, 2),
                                                              )
                                                            ],
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                30),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: InkWell(
                            onTap: () {},
                            child: SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const Align(
                                          alignment:
                                          AlignmentDirectional.centerStart,
                                          child: Icon(
                                            Iconsax.heart,
                                            color: Colors.blueGrey,
                                            size: 30,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 20),
                                          child: Text(
                                            'Support and Service',
                                            style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,

                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: InkWell(
                            onTap: () {
                            },
                            child: SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const Align(
                                          alignment:
                                          AlignmentDirectional.centerStart,
                                          child: Icon(
                                            Iconsax.logout,
                                            color: Colors.red,
                                            size: 30,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 20),
                                          child: Text(
                                            'Log Out',
                                            style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
