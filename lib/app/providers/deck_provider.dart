import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/card_model.dart';

class DeckProvider with ChangeNotifier {
  List<CardModel> _deck1 = [];
  List<CardModel> _deck2 = [];
  List<CardModel> _deck3 = [];

  List<CardModel> get deck1 => _deck1;
  List<CardModel> get deck2 => _deck2;
  List<CardModel> get deck3 => _deck3;

  Future<void> addToDeck(int deckNumber, CardModel card) async {
    switch (deckNumber) {
      case 1:
        _deck1.add(card);
        break;
      case 2:
        _deck2.add(card);
        break;
      case 3:
        _deck3.add(card);
        break;
    }
    await _saveDecks();
    notifyListeners();
  }

  Future<void> removeFromDeck(int deckNumber, CardModel card) async {
    switch (deckNumber) {
      case 1:
        _deck1.remove(card);
        break;
      case 2:
        _deck2.remove(card);
        break;
      case 3:
        _deck3.remove(card);
        break;
    }
    await _saveDecks();
    notifyListeners();
  }

  Future<void> clearDeck(int deckNumber) async {
    switch (deckNumber) {
      case 1:
        _deck1.clear();
        break;
      case 2:
        _deck2.clear();
        break;
      case 3:
        _deck3.clear();
        break;
    }
    await _saveDecks();
    notifyListeners();
  }

  Future<void> _saveDecks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('deck1', jsonEncode(_deck1.map((e) => e.toJson()).toList()));
    prefs.setString('deck2', jsonEncode(_deck2.map((e) => e.toJson()).toList()));
    prefs.setString('deck3', jsonEncode(_deck3.map((e) => e.toJson()).toList()));
  }

  Future<void> loadDecks() async {
    final prefs = await SharedPreferences.getInstance();
    _deck1 = _loadDeckFromPrefs(prefs.getString('deck1'));
    _deck2 = _loadDeckFromPrefs(prefs.getString('deck2'));
    _deck3 = _loadDeckFromPrefs(prefs.getString('deck3'));
    notifyListeners();
  }

  List<CardModel> _loadDeckFromPrefs(String? jsonStr) {
    if (jsonStr == null) return [];
    final List<dynamic> decoded = jsonDecode(jsonStr);
    return decoded.map((e) => CardModel.fromJson(e)).toList();
  }
}
