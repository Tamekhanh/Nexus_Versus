import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_versus/app/modules/debug_build/controllers/debug_build_controller.dart';

class LayoutController extends GetxController with GetSingleTickerProviderStateMixin {
  //TODO: Implement LayoutController
  final currentIndex = 0.obs;
  late TabController tabController;
  final count = 0.obs;

  final debugController = Get.find<DebugBuildController>();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentIndex.value = tabController.index;
      }
    });
  }

  void onTabChange(int index) {
    // Nếu đang ở tab Debug (2) và chuyển sang tab khác => stop nhạc
    if (currentIndex.value == 2 && index != 2) {
      try {
        final debugController = Get.find<DebugBuildController>();
        debugController.loopPlayer.stop();
      } catch (e) {
        // Controller chưa được khởi tạo thì bỏ qua
      }
    } else if (currentIndex.value != 2 && index == 2) {
      // Nếu đang chuyển sang tab Debug => start nhạc
      debugController.loopPlayer.start();
    }

    currentIndex.value = index;
    tabController.animateTo(index);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
