import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';
import 'package:nexus_versus/app/modules/battle/controllers/battle_controller.dart';

final BeautifulDay = SpellCardModel(
  id: "spell004",
  name: "Blessing of the Morning",
  description: "As the first light of dawn touches the land, a gentle warmth fills your soul. "
      "This spell grants you the blessing of clarity and preparation—draw two additional cards from your deck and ready yourself for the trials ahead.",
  imageUrl: "image_card/spell_card/beautiful_day.png",
  level: 10,
  onPlace: (context) => onPlace(context),
  onAttack: (context) {},
  cardSpecial: Color(0xFFDFDFDF),
  series: ["Yokai"],
);

void onPlace(BuildContext context) {
  // This function can be used to handle any additional logic when the card is placed
  // For example, you might want to trigger an animation or update the game state
  final controller = Get.find<BattleController>();
  final isPlayer1 = controller.currentTurn.value == Player.player1;
  final player = isPlayer1 ? Player.player1 : Player.player2;
  controller.drawMultipleCards(2, player: player);



}