import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_versus/app/data/card_game/card_reformat.dart';
import 'package:nexus_versus/app/models/card_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Giả sử đây là map chứa tất cả card với key = id của card

class DeckController extends GetxController {
  final RxList<CardModel> deck1 = <CardModel>[].obs;
  final RxList<CardModel> deck2 = <CardModel>[].obs;
  final RxList<CardModel> deck3 = <CardModel>[].obs;
  var currentDeckIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadDecks();
  }

  Future<void> loadDecks() async {
    final prefs = await SharedPreferences.getInstance();

    // Lấy list id từ prefs, nếu null thì trả về []
    List<String>? deck1Ids = prefs.getStringList('deck1');
    List<String>? deck2Ids = prefs.getStringList('deck2');
    List<String>? deck3Ids = prefs.getStringList('deck3');

    deck1.value = _loadDeckFromIds(deck1Ids);
    deck2.value = _loadDeckFromIds(deck2Ids);
    deck3.value = _loadDeckFromIds(deck3Ids);
  }

  List<CardModel> _loadDeckFromIds(List<String>? ids) {
    if (ids == null) return [];

    // Lọc những id có trong cardData
    final validCards = ids.where((id) => cardData.containsKey(id)).map((id) => cardData[id]!).toList();

    // Sắp xếp theo id dưới dạng số (nếu id luôn là số hợp lệ)
    validCards.sort((a, b) {
      final int aId = int.tryParse(a.id) ?? 0;
      final int bId = int.tryParse(b.id) ?? 0;
      return aId.compareTo(bId);
    });

    return validCards;
  }


  void removeCardFromCurrentDeck(CardModel card) {
    switch (currentDeckIndex.value) {
      case 0:
        deck1.remove(card);
        break;
      case 1:
        deck2.remove(card);
        break;
      case 2:
        deck3.remove(card);
        break;
    }
    saveDecks();
  }



  void setCurrentDeck(int index) {
    currentDeckIndex.value = index;
  }

  void addCardToCurrentDeck(CardModel card) {
    switch (currentDeckIndex.value) {
      case 0:
        deck1.add(card);
        break;
      case 1:
        deck2.add(card);
        break;
      case 2:
        deck3.add(card);
        break;
    }
    saveDecks();
  }

  Future<void> saveDecks() async {
    final prefs = await SharedPreferences.getInstance();

    // Lưu danh sách id thay vì lưu toàn bộ object
    prefs.setStringList('deck1', deck1.map((card) => card.id).toList());
    prefs.setStringList('deck2', deck2.map((card) => card.id).toList());
    prefs.setStringList('deck3', deck3.map((card) => card.id).toList());
  }

  void clearCurrentDeck() {
    switch (currentDeckIndex.value) {
      case 0:
        deck1.clear();
        break;
      case 1:
        deck2.clear();
        break;
      case 2:
        deck3.clear();
        break;
    }
    saveDecks();
  }
}
