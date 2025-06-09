import 'package:get/get.dart';
import 'package:nexus_versus/app/data/card_game/card_reformat.dart';
import 'package:nexus_versus/app/models/card_model.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';

enum CardFilterType { all, spell, unit }

class CardListController extends GetxController {
  //TODO: Implement CardListController

  var hoveredCardIndex = (-1).obs;
  var selectedCardIndex = 0.obs;
  final count = 0.obs;

  var filterType = CardFilterType.all.obs;

  List<CardModel> get cardList {
    final allCards = cardData.values.toList();
    switch (filterType.value) {
      case CardFilterType.spell:
        return allCards.where((card) => card is SpellCardModel).toList();
      case CardFilterType.unit:
        return allCards.where((card) => card is UnitCardModel).toList();
      default:
        return allCards;
    }
  }

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
