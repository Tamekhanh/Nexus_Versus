import 'package:get/get.dart';
import 'package:nexus_versus/app/data/card_game/card_reformat.dart';
import 'package:nexus_versus/app/models/card_model.dart';

class CardListController extends GetxController {
  //TODO: Implement CardListController

  var hoveredCardIndex = (-1).obs;
  var selectedCardIndex = 0.obs;
  final count = 0.obs;

  List<CardModel> get cardList => cardData.values.toList();

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
