import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nexus_versus/app/models/in_battle_model.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';
import 'package:nexus_versus/app/modules/battle/controllers/battle_controller.dart';

final HeavenlyThunder = UnitCardModel(
  id: "unit004",
  name: "Heavenly Thunder",
  description: "Upon being summoned, a divine tempest is unleashed, striking all enemy units for 500 damage. "
      "Forged from the wrath of the skies, it brings judgment from above.",
  imageUrl: "image_card/unit_card/heavenly_thunder.png",
  level: 6,
  attackPower: 1500,
  healthPoints: 2000,
  onPlace: (context){
    final controller = Get.find<BattleController>();
    final isPlayer1 = controller.currentTurn.value == Player.player1;
    final enemyField = isPlayer1 ? controller.onFieldP2 : controller.onFieldP1;

    for (int i = 0; i < enemyField.length; i++) {
      final card = enemyField[i];
      if (kDebugMode) {
        print('Card at $i is ${card.runtimeType}');
      }
      if (card is UnitCardModel) {
        if (kDebugMode) {
          print('Before damage: ${card.name} hp=${card.currentHealthPoints}');
        }
        card.currentHealthPoints -= 500;
        if (kDebugMode) {
          print('After damage: ${card.name} hp=${card.currentHealthPoints}');
        }
        if (card.currentHealthPoints <= 0) {
          controller.onDead(i, player: isPlayer1 ? Player.player2 : Player.player1);
          enemyField[i] = null;
          if (kDebugMode) {
            print('${card.name} destroyed!');
          }
        }
      }
    }
    enemyField.refresh();

    enemyField.refresh();
  },
  onAttack: (context) {},
  cardSpecial: Color(0xFF001157), // Brown color for God Hand
  series: ["Myth"],
);