import 'package:get/get.dart';

import '../controllers/card_list_controller.dart';

class CardListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardListController>(
      () => CardListController(),
    );
  }
}
