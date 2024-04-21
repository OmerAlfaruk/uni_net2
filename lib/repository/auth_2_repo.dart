import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uni_link/features/main/main_screen.dart';
import 'package:uni_link/features/on_boarding/pages/on_boarding_screen.dart';
import 'package:uni_link/features/user/presentation/manager/auth/auth_cubit.dart';
import 'package:uni_link/features/user/presentation/pages/login/sign_in_page.dart';
import 'package:uni_link/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:uni_link/utils/exceptions/firebase_exceptions.dart';
import 'package:uni_link/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    screenRedirect();
  }

  /// show relevant Screen
  void screenRedirect() {
    BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        if (authState is Authenticated) {
          return MainScreen(
            uid: authState.uid,
          );
        } else if (deviceStorage.read('IsFirstTime') == true) {
          return const OnBoardingPage();
        } else {
          return const SignInPage();
        }
      },
    );
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw OFirebaseAuthException(e.code).message;
      // Re-throwing the exception to handle it elsewhere if needed
    } on FormatException catch (e) {
      throw OFirebaseException(e.message);
    } on PlatformException catch (e) {
      throw OPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong please try again';
    }
  }

  /// EmailAuthentication - FORGET PASSWORD
  Future<void> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw OFirebaseAuthException(e.code).message;
      // Re-throwing the exception to handle it elsewhere if needed
    } on FormatException catch (e) {
      throw OFirebaseException(e.message);
    } on PlatformException catch (e) {
      throw OPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong please try again';
    }
  }
}
