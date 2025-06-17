import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';
import 'package:nexus_versus/app/modules/battle/controllers/battle_controller.dart';

final Kurohime = UnitCardModel(
  id: "unit005",
  name: "Kurohime",
  description: "An elegant but merciless noble from a forgotten manor veiled in shadow. While this unit stands on the field, any spell cards summoned afterward the end of the turn will be destroyed.",
  imageUrl: "image_card/unit_card/kurohime.png",
  level: 7,
  attackPower: 1000,
  healthPoints: 4000,
  onPlace: (context) {
    onPlace(context);
  },
  onAttack: (context) {},
  onDead: (context, player) {},
  onEnemyPlace: (context, enemy) {
    final controller = Get.find<BattleController>();
    final field = controller.getField(enemy);

    for (int i = 5; i < 10; i++) {
      if (field[i] != null) {
        controller.graveCardsP2.add(field[i]);
        field[i] = null;
      }
    }

    field.refresh();
    controller.graveCardsP2.refresh();

    if (kDebugMode) {
      print('Kurohime đã phá hủy các spell của đối thủ!');
    }
  },
  cardSpecial: Color(0xFF001157),
  onActive: (context, enemy) {
    onActive(context, enemy);
  },
  series: ["Myth"],
);

void onPlace(BuildContext context) async{
  final controller = Get.find<BattleController>();
  final isPlayer1 = controller.currentTurn.value == Player.player1;
  final field = isPlayer1 ? controller.onFieldP1 : controller.onFieldP2;
  final enemyField = isPlayer1 ? controller.onFieldP2 : controller.onFieldP1;
  final playerGrave = isPlayer1 ? controller.graveCardsP1 : controller.graveCardsP2;
  for (int i = 0; i < enemyField.length; i++) {
    final card = enemyField[i];
    if (card is SpellCardModel) {
      controller.onDead(i, player: isPlayer1 ? Player.player2 : Player.player1);
      enemyField[i] = null;
      if (kDebugMode) {
        print('Kurohime destroyed ${card.name} at index $i');
      }
    }
  }
  enemyField.refresh();
}

void onActive(BuildContext context, Player owner) async {
  final controller = Get.find<BattleController>();
  final enemy = owner == Player.player1 ? Player.player2 : Player.player1;
  final enemyField = controller.getField(enemy);

  for (int i = 0; i < enemyField.length; i++) {
    final card = enemyField[i];
    if (card is SpellCardModel) {
      controller.onDead(i, player: enemy);
      enemyField[i] = null;
      if (kDebugMode) {
        print('[Kurohime] Destroyed ${card.name} on enemy field at index $i');
      }
    }
  }

  enemyField.refresh();
}
