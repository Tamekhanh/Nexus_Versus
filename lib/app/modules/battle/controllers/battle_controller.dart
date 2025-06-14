import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:nexus_versus/app/data/debug/debug_data.dart';
import 'package:nexus_versus/app/models/card_model.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';
import 'package:nexus_versus/app/modules/battle/controllers/loop_part_player.dart';
import 'package:nexus_versus/app/widgets/card_information.dart';


enum Player { player1, player2 }

extension ListExtension<T> on List<T> {
  T? elementAtOrNull(int index) => (index >= 0 && index < length) ? this[index] : null;
}

class BattleController extends GetxController {
  var hoveredCardIndex = (-1).obs;
  var selectedCardIndex = (-1).obs;
  final count = 0.obs;
  final loopPlayer = LoopPartsPlayer();

  RxList<CardModel?> handCardsP2 = <CardModel?>[].obs;
  RxList<CardModel?> deckCardsP2 = <CardModel?>[].obs;
  RxList<CardModel?> handCardsP1 = <CardModel?>[].obs;
  RxList<CardModel?> deckCardsP1 = <CardModel?>[].obs;

  RxList<CardModel?> onFieldP1 = List<CardModel?>.filled(10, null).obs;
  RxList<CardModel?> onFieldP2 = List<CardModel?>.filled(10, null).obs;

  RxList<CardModel?> graveCardsP1 = <CardModel?>[].obs;
  RxList<CardModel?> graveCardsP2 = <CardModel?>[].obs;

  var selectedAttackerIndex = (-1).obs;

  final AudioPlayer _audioPlayerCardSelect = AudioPlayer();
  final AudioPlayer _audioPlayerCardPlace = AudioPlayer();

  late BuildContext battleContext;

  bool isP1AI = true;
  Rx<Player> currentTurn = Player.player1.obs;
  bool _isAITurnRunning = false;

  void setBattleContext(BuildContext context) {
    battleContext = context;
  }

  void shuffleDeck(Player player) {
    final deck = getDeck(player);
    deck.shuffle();
    deck.refresh();
    print('Deck for $player has been shuffled.');
  }

  @override
  void onInit() {
    super.onInit();

    final initialCardsP1 = debugData.entries
        .expand((entry) => List.generate(entry.value, (_) => entry.key))
        .toList();
    final initialCardsP2 = debugData.entries
        .expand((entry) => List.generate(entry.value, (_) => entry.key))
        .toList();

    handCardsP1.assignAll(initialCardsP1);
    deckCardsP1.assignAll(List.of(initialCardsP1));
    handCardsP2.assignAll(initialCardsP2);
    deckCardsP2.assignAll(List.of(initialCardsP2));

    shuffleDeck(Player.player1);
    shuffleDeck(Player.player2);

    if (isP1AI && currentTurn.value == Player.player1) {
      Future.delayed(const Duration(milliseconds: 500), aiPlayTurn);
    }
  }

  @override
  void onClose() {
    super.onClose();
    loopPlayer.stop();
    _audioPlayerCardSelect.dispose();
    _audioPlayerCardPlace.dispose();
  }

  RxList<CardModel?> getField(Player player) =>
      player == Player.player1 ? onFieldP1 : onFieldP2;

  RxList<CardModel?> getDeck(Player player) =>
      player == Player.player1 ? deckCardsP1 : deckCardsP2;

  RxList<CardModel?> getHand(Player player) =>
      player == Player.player1 ? handCardsP1 : handCardsP2;

  Future<void> _playSelectSound() async {
    try {
      await _audioPlayerCardSelect.play(
        AssetSource('sfx/Card_Select.mp3'),
        volume: 0.5,
      );
    } catch (e) {
      print('Error playing select sound: $e');
    }
  }

  Future<void> _playPlaceSound() async {
    try {
      await _audioPlayerCardPlace.play(
        AssetSource('sfx/Card_Apply.mp3'),
        volume: 0.5,
      );
    } catch (e) {
      print('Error playing place sound: $e');
    }
  }

  void placeCardOnField({
    required Player player,
    required int fieldIndex,
    required BuildContext context,
  }) {
    final selIndex = selectedCardIndex.value;
    if (selIndex == -1) return;

    final hand = getHand(player);
    final selected = hand.elementAtOrNull(selIndex);
    if (selected == null) return;

    final field = getField(player);
    if (field[fieldIndex] != null) return;

    if (fieldIndex <= 4 && selected is! UnitCardModel) return;
    if (fieldIndex >= 5 && selected is! SpellCardModel) return;


    if (selected is UnitCardModel) {
      final placedCard = selected.toInBattle();
      placedCard.currentHealthPoints = placedCard.healthPoints;
      field[fieldIndex] = placedCard;
      placedCard.onPlace?.call(context);
    } else if (selected is SpellCardModel) {
      field[fieldIndex] = selected;
      selected.onPlace?.call(context);
    }

    _playPlaceSound();

    selectedCardIndex.value = -1;
    hand.removeAt(selIndex);

    field.refresh();
    hand.refresh();

    print('[${player.name}] placed card at index $fieldIndex');
  }

  void placeCardOnFieldP1(int fieldIndex, BuildContext context) {
    placeCardOnField(player: Player.player1, fieldIndex: fieldIndex, context: context);
  }

  void placeCardOnFieldP2(int fieldIndex, BuildContext context) {
    placeCardOnField(player: Player.player2, fieldIndex: fieldIndex, context: context);
  }

  void selectCard(int index) {
    if (index < 0) return;
    selectedCardIndex.value = index;
    _playSelectSound();
  }

  void drawCard({required Player player}) {
    final deck = getDeck(player);
    final hand = getHand(player);

    if (deck.isEmpty) {
      print('Deck is empty, cannot draw card for $player');
      return;
    }

    final drawnCard = deck.removeLast();
    hand.add(drawnCard);

    deck.refresh();
    hand.refresh();

    print('[$player] Drew card: $drawnCard');
  }

  void drawMultipleCards(int count, {required Player player}) {
    final deck = getDeck(player);
    final hand = getHand(player);

    for (int i = 0; i < count; i++) {
      if (deck.isEmpty) {
        if (kDebugMode) {
          print('Deck empty, stopped drawing at $i cards for $player');
        }
        break;
      }
      drawCard(player: player);
    }
  }

  Future<void> aiPlayTurn() async {
    if (currentTurn.value != Player.player1) return;
    if (_isAITurnRunning) return;
    _isAITurnRunning = true;
    drawCard(player: Player.player1);
    if (kDebugMode) {
      print('AI thinking...');
    }

    for (int i = 0; i < handCardsP1.length; i++) {
      final card = handCardsP1[i];
      if (card == null) continue;

      final field = onFieldP1;
      int? emptyIndex;

      if (card is UnitCardModel) {
        emptyIndex = _findEmptySlot(field, 0, 4);
      } else if (card is SpellCardModel) {
        emptyIndex = _findEmptySlot(field, 5, field.length - 1);
      }

      if (emptyIndex != null) {
        final context = Get.overlayContext;  // <-- Dùng overlayContext thay vì Get.context
        if (context != null) {
          selectedCardIndex.value = i;
          placeCardOnField(player: Player.player1, fieldIndex: emptyIndex, context: context);

          card.onPlace?.call(context);
        } else {
          if (kDebugMode) {
            print('Warning: No overlay context available to place card');
          }
        }

        drawCard(player: Player.player1);

        currentTurn.value = Player.player2;
        if (kDebugMode) {
          print('AI placed card at $emptyIndex and ended turn.');
        }
        _isAITurnRunning = false;
        return;
      }
    }

    currentTurn.value = Player.player2;
    if (kDebugMode) {
      print('AI cannot play any card, turn ended.');
    }
    _isAITurnRunning = false;
  }


  int? _findEmptySlot(RxList<CardModel?> field, int start, int end) {
    for (int idx = start; idx <= end; idx++) {
      if (field[idx] == null) {
        return idx;
      }
    }
    return null;
  }

  void endTurn() {
    if (currentTurn.value == Player.player2) {
      currentTurn.value = Player.player1;

      if (isP1AI) {
        Future.delayed(const Duration(milliseconds: 500), aiPlayTurn);
      }
    }
  }

  void selectAttacker(int index) {
    if (index < 0 || index >= onFieldP2.length) return;
    final card = onFieldP2[index];
    if (card is UnitCardModel) {
      selectedAttackerIndex.value = index;
      print('Player 2 selected attacker at index $index');
    }
  }

  void onDead(int index, {required Player player}) {
    final field = getField(player);
    final card = field.elementAtOrNull(index);
    if (card == null) return;
    player == Player.player1
        ? graveCardsP1.add(card)
        : graveCardsP2.add(card);
    if (card is UnitCardModel) {
      card.onDead?.call(battleContext);
      if (kDebugMode) {
        print('Card ${card.name} is dead at index $index');
      }
    } else if (card is SpellCardModel) {
      card.onDead?.call(battleContext);
      if (kDebugMode) {
        print('Spell ${card.name} is deactivate at index $index');
      }
    }
  }

  void cardInformation(CardModel card) {
    showDialog(
      context: battleContext,
      builder: (context) => CardInformationDialog(card: card),
    );
  }

  // void attackTarget(int targetIndex) {
  //   final attackerIndex = selectedAttackerIndex.value;
  //   if (attackerIndex == -1) return;
  //
  //   final attacker = onFieldP2[attackerIndex];
  //   final target = onFieldP1.elementAtOrNull(targetIndex);
  //
  //   if (attacker is! UnitCardModel) return;
  //
  //   if (target == null) {
  //     // Tấn công trực tiếp nếu không có mục tiêu (ví dụ như Nexus)
  //     print('Player 2 attacks Nexus directly with ${attacker.name} for ${attacker.attack} damage');
  //     // TODO: Giảm máu Nexus
  //   } else if (target is UnitCardModel) {
  //     // Tấn công lẫn nhau
  //     target -= attacker.attack;
  //     attacker.hp -= target.attack;
  //     print('Combat: ${attacker.name} (${attacker.hp}) vs ${target.name} (${target.hp})');
  //
  //     // Kiểm tra nếu thẻ chết
  //     if (target.hp <= 0) {
  //       onFieldP1[targetIndex] = null;
  //       print('${target.name} was destroyed!');
  //     }
  //     if (attacker.hp <= 0) {
  //       onFieldP2[attackerIndex] = null;
  //       print('${attacker.name} was destroyed!');
  //     }
  //
  //     onFieldP1.refresh();
  //     onFieldP2.refresh();
  //   }
  //
  //   selectedAttackerIndex.value = -1;
  // }

}
