import 'package:get/get.dart';

import '../controllers/debug_build_controller.dart';

class DebugBuildBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DebugBuildController>(
      () => DebugBuildController(),
    );
  }
}
