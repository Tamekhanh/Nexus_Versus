import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';

import '../../../modules/battle/controllers/battle_controller.dart';

final Nightingale_HealthCare = SpellCardModel(
  id: "spell006",
  name: "Nightingale Healthcare",
  description: "A beacon of hope in the darkest times, this spell provides healing and support to allies. When this spell is activated, restores 500 HP to all allies until this card is destroyed." ,
  imageUrl: "image_card/spell_card/nightingale_healthcare.png",
  level: 6,
  onPlace: (context){
    onPlace(context);
  },
  onAttack: (context) {},
  onDead: (context, player) {
    onDead(context, player);
  },
  series: ["War of Humankind"],
  onActive: (context, player) {
    onActive(context, player);
  },
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
        card.currentHealthPoints += 500;
        card.effects ??= [];
        card.effects!.add("Nightingale_HealthCare");
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error in Nightingale HealthCare onPlace: $e");
    }
  }
}

Future<void> onActive(BuildContext context, Player player) async {
  final controller = Get.find<BattleController>();
  final enemy = player == Player.player1 ? Player.player2 : Player.player1;
  final playerField = controller.getField(player);

  try {
    for (int i = 0; i < playerField.length; i++) {
      final card = playerField[i];
      if (kDebugMode) {
        print('Card at $i is ${card.runtimeType}');
      }
      if (card is UnitCardModel) {
        card.currentHealthPoints += 500;
        card.effects ??= [];
        if (card.effects?.contains("Nightingale_HealthCare") == false) {
          if (kDebugMode) {
            print("Adding Nightingale_HealthCare effect to ${card.name}");
          }
          card.effects!.add("Nightingale_HealthCare");
        }
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error in Nightingale HealthCare onPlace: $e");
    }
  }
}

Future<void> onDead(BuildContext context, Player player) async {
  final controller = Get.find<BattleController>();
  final field = controller.getField(player);

  try {
    for (int i = 0; i < field.length; i++) {
      final card = field[i];
      if (card is UnitCardModel) {
        if (card.effects?.contains("Nightingale_HealthCare") == true) {
          card.effects!.remove("Nightingale_HealthCare");
        }
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error in Nightingale HealthCare onPlace: $e");
    }
  }
}

