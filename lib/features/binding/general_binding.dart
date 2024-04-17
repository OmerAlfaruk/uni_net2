import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:uni_link/features/user/credential/presentation/widgets/widget_controller/terms_and_condition_conroller.dart';

import '../../utils/connection/connectivity_manager.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(TermsAndConditionController());

  }

}