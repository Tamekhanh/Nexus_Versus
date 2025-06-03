import 'package:get/get.dart';

import '../controllers/deck_controller.dart';

class DeckBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeckController>(
      () => DeckController(),
    );
  }
}
