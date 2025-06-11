import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';
import 'package:nexus_versus/app/modules/battle/controllers/battle_controller.dart';

final GodHand = UnitCardModel(
  id: "unit003",
  name: "God Hand",
  description: "When this unit is summoned, it unleashes divine wrath — instantly destroying all enemy units with 1000 or less ATK. A harbinger of judgment from beyond the veil.",
  imageUrl: "image_card/unit_card/god_hand.png",
  level: 10,
  attackPower: 3000,
  healthPoints: 2000,
  onPlace: (context) {
    final controller = Get.find<BattleController>();
    final isPlayer1 = controller.currentTurn.value == Player.player1;
    final enemyField = isPlayer1 ? controller.onFieldP2 : controller.onFieldP1;

    for (int i = 0; i < enemyField.length; i++) {
      final card = enemyField[i];
      if (card is UnitCardModel && card.currentAttackPower <= 1000) {
        controller.onDead(i, player: isPlayer1 ? Player.player2 : Player.player1);
        enemyField[i] = null;
        if (kDebugMode) {
          print('God Hand destroyed ${card.name} at index $i');
        }
      }
    }

    enemyField.refresh();
  },
  onAttack: (context) {},
  cardSpecial: Color(0xFF001157), // Brown color for God Hand
  series: ["Myth"],
);