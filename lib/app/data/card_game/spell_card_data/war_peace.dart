import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';

import '../../../modules/battle/controllers/battle_controller.dart';

final WarAndPeace = SpellCardModel(
  id: "spell002",
  name: "Wings of War, Petals of Peace",
  description: "Forged in times of chaos, this spell symbolizes the delicate balance between destruction and harmony. When this spell is activated, increases the ATK of all allies by 1000 until this card is destroyed. " ,
  imageUrl: "image_card/spell_card/war_peace.png",
  level: 10,
  onPlace: (context){
    onPlace(context);
  },
  onAttack: (context) {},
  onDead: (context) {
    onDead(context);
  },
  series: ["Crow"],
);

Future<void> onPlace(BuildContext context) async {
  final controller = Get.find<BattleController>();
  final isPlayer1 = controller.currentTurn.value == Player.player1;
  final field = isPlayer1 ? controller.onFieldP1 : controller.onFieldP2;

  try {
    for (int i = 0; i < field.length; i++) {
      final card = field[i];
      if (kDebugMode) {
        print('Card at $i is ${card.runtimeType}');
      }
      if (card is UnitCardModel) {
        if (kDebugMode) {
          print('Before WarAndPeace effect: ${card.name} atk=${card.currentAttackPower}');
        }
        card.currentAttackPower += 1000;
        card.effects ??= [];
        card.effects!.add("WarAndPeace");
        if (kDebugMode) {
          print('After WarAndPeace effect: ${card.name} atk=${card.currentAttackPower}');
        }
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error in WarAndPeace onPlace: $e");
    }
  }
}

Future<void> onDead(BuildContext context) async {
  final controller = Get.find<BattleController>();
  final isPlayer1 = controller.currentTurn.value == Player.player1;
  final field = isPlayer1 ? controller.onFieldP1 : controller.onFieldP2;

  try {
    for (int i = 0; i < field.length; i++) {
      final card = field[i];
      if (card is UnitCardModel) {
        if (card.effects?.contains("WarAndPeace") == true) {
          card.currentAttackPower -= 1000;
          card.effects!.remove("WarAndPeace");
        }
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error in WarAndPeace onPlace: $e");
    }
  }
}

