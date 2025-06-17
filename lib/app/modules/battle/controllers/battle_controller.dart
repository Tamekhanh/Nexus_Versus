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
  var isLoading = true.obs;
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
    if (kDebugMode) {
      print('Deck for $player has been shuffled.');
    }
  }

  @override
  void onInit() {
    super.onInit();

    isLoading.value = true; // Start loading

    Future.delayed(const Duration(milliseconds: 500), () {
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

      isLoading.value = false; // Finish loading

      if (isP1AI && currentTurn.value == Player.player1) {
        Future.delayed(const Duration(milliseconds: 500), aiPlayTurn);
      }
    });
    isLoading = false.obs;
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

  RxList<CardModel?> getGrave(Player player) =>
      player == Player.player1 ? graveCardsP1 : graveCardsP2;

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

    /// 1. Tạo bản sao trước khi đặt
    CardModel? previewCard;
    if (selected is UnitCardModel) {
      previewCard = selected.toInBattle();
      (previewCard as UnitCardModel).currentHealthPoints = previewCard.healthPoints;
    } else if (selected is SpellCardModel) {
      previewCard = selected;
    }


    /// 3. Kiểm tra lại ô trống (quân địch có thể đã phá huỷ bài)
    if (field[fieldIndex] != null) return;

    /// 4. Gán bài và gọi onPlace
    field[fieldIndex] = previewCard;

    if (previewCard is UnitCardModel) {
      previewCard.onPlace?.call(context);
    } else if (previewCard is SpellCardModel) {
      previewCard.onPlace?.call(context);
    }

    _playPlaceSound();

    selectedCardIndex.value = -1;
    hand.removeAt(selIndex);

    field.refresh();
    hand.refresh();

    if (kDebugMode) {
      print('[${player.name}] placed card at index $fieldIndex');
    }
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
    if (currentTurn.value != Player.player1 || _isAITurnRunning) return;
    _isAITurnRunning = true;

    print('[AI] ---- Turn Start ----');

    // 0. Reset số lượt tấn công
    resetAttackAttempts(Player.player1);

    // 1. Rút bài
    drawCard(player: Player.player1);
    await Future.delayed(const Duration(milliseconds: 400));

    // 2. Đặt bài nếu có thể
    for (int i = 0; i < handCardsP1.length; i++) {
      final card = handCardsP1[i];
      if (card == null) continue;

      final field = onFieldP1;
      int? emptyIndex;

      if (card is UnitCardModel) {
        emptyIndex = _findEmptySlot(field, 0, 4); // Lính
      } else if (card is SpellCardModel) {
        emptyIndex = _findEmptySlot(field, 5, 9); // Phép
      }

      if (emptyIndex != null) {
        final context = Get.overlayContext;
        if (context != null) {
          selectedCardIndex.value = i;
          placeCardOnField(player: Player.player1, fieldIndex: emptyIndex, context: context);
          await Future.delayed(const Duration(milliseconds: 600));
          break; // Đặt 1 lá mỗi lượt
        }
      }
    }

    // 3. Tấn công nếu có thể
    for (int attackerIndex = 0; attackerIndex < onFieldP1.length; attackerIndex++) {
      final attacker = onFieldP1[attackerIndex];
      if (attacker is UnitCardModel && attacker.attackAttempt > 0) {
        for (int targetIndex = 0; targetIndex < onFieldP2.length; targetIndex++) {
          final target = onFieldP2[targetIndex];
          if (target is UnitCardModel) {
            selectedAttackerIndex.value = attackerIndex;
            await Future.delayed(const Duration(milliseconds: 500)); // Delay giữa các đòn tấn công
            attack(
              attackerPlayer: Player.player1,
              attackerIndex: attackerIndex,
              targetIndex: targetIndex,
            );
            selectedAttackerIndex.value = -1; // Clear selection after attack
            break;
          }
        }
      }
    }

    // 4. Kết thúc lượt
    await Future.delayed(const Duration(milliseconds: 400));
    currentTurn.value = Player.player2;
    print('[AI] ---- Turn End ----');

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
    resetAttackAttempts(Player.player2);

    for (final card in onFieldP2) {
      if (card is UnitCardModel) {
        card.onActive?.call(battleContext, Player.player2);
      } else if (card is SpellCardModel) {
        card.onActive?.call(battleContext, Player.player2);
      }
    }
    for (final card in onFieldP1) {
      if (card is UnitCardModel) {
        card.onActive?.call(battleContext, Player.player1);
      } else if (card is SpellCardModel) {
        card.onActive?.call(battleContext, Player.player1);
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

    // Đưa vào mộ
    (player == Player.player1 ? graveCardsP1 : graveCardsP2).add(card);

    // Gọi hiệu ứng chết, truyền đúng người sở hữu
    if (card is UnitCardModel) {
      card.onDead?.call(battleContext, player);
      if (kDebugMode) {
        print('Card ${card.name} is dead at index $index');
      }
    } else if (card is SpellCardModel) {
      card.onDead?.call(battleContext, player);
      if (kDebugMode) {
        print('Spell ${card.name} is deactivated at index $index');
      }
    }
  }

  void cardInformation(CardModel card) {
    showDialog(
      context: battleContext,
      builder: (context) => CardInformationDialog(card: card),
    );
  }

  void attack({
    required Player attackerPlayer,
    required int attackerIndex,
    required int targetIndex,
  }) {
    final attackerField = getField(attackerPlayer);
    final targetPlayer = attackerPlayer == Player.player1 ? Player.player2 : Player.player1;
    final targetField = getField(targetPlayer);

    final attackerCard = attackerField.elementAtOrNull(attackerIndex);
    final targetCard = targetField.elementAtOrNull(targetIndex);

    if (attackerCard is! UnitCardModel) {
      print('No valid attacker at index $attackerIndex');
      return;
    } else {
      if (attackerCard.attackAttempt <= 0) {
        print('Attacker ${attackerCard.name} has no attack attempts left.');
        return;
      }
      if (targetCard is! UnitCardModel) {
        print('No valid target at index $targetIndex');
        return;
      }



      // Tấn công!
      targetCard.currentHealthPoints -= attackerCard.currentAttackPower;
      print(
          '[ATTACK] ${attackerPlayer.name}\'s ${attackerCard.name} attacked ${targetPlayer.name}\'s ${targetCard.name} '
              'for ${attackerCard.currentAttackPower} damage. Target HP: ${targetCard.currentHealthPoints}');

      // Nếu mục tiêu chết
      if (targetCard.currentHealthPoints <= 0) {
        onDead(targetIndex, player: targetPlayer);
        targetField[targetIndex] = null;
      }

      // Clear attacker selection (nếu muốn)
      if (attackerPlayer == Player.player2) {
        selectedAttackerIndex.value = -1;
      }
      attackerCard.attackAttempt--;
      targetField.refresh();
    }
  }

  void resetAttackAttempts(Player player) {
    final field = getField(player);
    for (final card in field) {
      if (card is UnitCardModel) {
        card.attackAttempt = card.maxAttackAttempt;
      }
    }
    field.refresh();
    debugPrint('[TURN] Reset attackAttempt for ${player.name}');
  }

}

