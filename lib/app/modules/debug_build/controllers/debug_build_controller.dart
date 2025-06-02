import 'package:get/get.dart';
import 'package:nexus_versus/app/data/debug/debug_data.dart';
import 'package:nexus_versus/app/models/card_model.dart';

class DebugBuildController extends GetxController {
  //TODO: Implement DebugBuildController
  var hoveredCardIndex = (-1).obs;
  var selectedCardIndex = (-1).obs;
  final count = 0.obs;

  RxList<CardModel?> cardList = <CardModel?>[].obs;

  var onField = <CardModel?>[].obs;

  @override
  void onInit() {
    super.onInit();
    cardList.value = debugData.entries
        .expand((entry) => List.generate(entry.value, (_) => entry.key))
        .toList();
    onField.value = List.filled(5, null);
  }

  void placeCardOnField(int fieldIndex) {
    final selectedIndex = selectedCardIndex.value;

    if (selectedIndex == -1 || onField[fieldIndex] != null) return;

    final selected = cardList[selectedIndex];
    if (selected == null) return;

    onField[fieldIndex] = selected;
    cardList.removeAt(selectedIndex);
    selectedCardIndex.value = -1;

    onField.refresh();
    cardList.refresh();
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
