import 'package:get/get.dart';
import 'package:nexus_versus/app/modules/battle/controllers/battle_controller.dart';
import 'package:nexus_versus/app/modules/card_list/controllers/card_list_controller.dart';
import 'package:nexus_versus/app/modules/debug_build/controllers/debug_build_controller.dart';
import 'package:nexus_versus/app/modules/deck/controllers/deck_controller.dart';
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
    Get.lazyPut<DebugBuildController>(
          () => DebugBuildController(),
    );
    Get.lazyPut<DeckController>(
          () => DeckController(),
    );
    Get.lazyPut<BattleController>(
          () => BattleController(),
    );
  }
}
