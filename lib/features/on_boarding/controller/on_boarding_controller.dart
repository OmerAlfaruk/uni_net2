import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uni_link/features/user/presentation/pages/login/sign_in_page.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  /// variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  /// Update current Index when Page Scroll

  void updatePageIndicator(index) => currentPageIndex.value = index;

  ///Jump to the Specific dot selected page

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  ///Update Current Index & jump to next page

  void nexPage() {
    if (currentPageIndex.value == 2) {
      final storage = GetStorage();
      storage.write('IsFirstTime', false);
      Get.offAll(const SignInPage());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  /// Update Current Index & Jump to the last Page
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
