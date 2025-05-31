import 'package:get/get.dart';
import 'package:nexus_versus/app/data/debug/debug_data.dart';
import 'package:nexus_versus/app/models/card_model.dart';

class DebugBuildController extends GetxController {
  //TODO: Implement DebugBuildController
  var hoveredCardIndex = (-1).obs;
  var selectedCardIndex = 0.obs;
  final count = 0.obs;

  List<CardModel> get cardList => debugData.entries
      .expand((entry) => List.generate(entry.value, (_) => entry.key))
      .toList();

  @override
  void onInit() {
    super.onInit();
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
