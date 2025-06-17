import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';
import 'package:nexus_versus/app/modules/battle/controllers/battle_controller.dart';

final RedCowBoy = UnitCardModel(
  id: "unit001",
  name: "Red Cowboy",
  description: "Quick Draw: when this unit is summoned, draw a card. \n Last bullet: when this unit is dead, draw a card.",
  imageUrl: "image_card/unit_card/red_cowboy.png",
  level: 5,
  attackPower: 1000,
  healthPoints: 1000,
  onPlace: (context) {
    quickdraw();
  },
  onAttack: (context) {},
  onDead: (context, player) {lastBullet(player);},
  cardSpecial: Colors.redAccent,
  series: ["Cowboy"],
);

void quickdraw() {
  final controller = Get.find<BattleController>();
  final isPlayer1 = controller.currentTurn.value == Player.player1;

  final player = isPlayer1 ? Player.player1 : Player.player2;

  controller.drawCard(player: player);

  debugPrint('active skill Quick Draw - Draw a card');
}

void lastBullet(Player owner) {
  final controller = Get.find<BattleController>();
  controller.drawCard(player: owner);
}

