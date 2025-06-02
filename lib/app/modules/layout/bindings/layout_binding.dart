import 'package:get/get.dart';
import 'package:nexus_versus/app/modules/card_list/controllers/card_list_controller.dart';
import 'package:nexus_versus/app/modules/home/controllers/home_controller.dart';

import '../controllers/layout_controller.dart';

class LayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LayoutController>(
      () => LayoutController(),
    );
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    Get.lazyPut<CardListController>(
          () => CardListController(),
    );
  }
}
