import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';
import 'package:nexus_versus/app/widgets/full_screen_image_text_shake.dart';

import '../../../modules/battle/controllers/battle_controller.dart';

final TripTornado = SpellCardModel(
  id: "spell005",
  name: "Trip Tornado",
  description: "A whirlwind of chaos descends, disrupting the battlefield. When this spell is cast, all spell cards on the field are destroyed.",
  imageUrl: "image_card/spell_card/trip_tornado.png",
  level: 10,
  onPlace: (context){onPlace(context);},
  onAttack: (context) {},
  series: ["Natural Disaster"],
);

Future<void> onPlace(BuildContext context) async {
  final controller = Get.find<BattleController>();
  final isPlayer1 = controller.currentTurn.value == Player.player1;
  final field = isPlayer1 ? controller.onFieldP1 : controller.onFieldP2;
  final enemyField = isPlayer1 ? controller.onFieldP2 : controller.onFieldP1;
  final playerGrave = isPlayer1 ? controller.graveCardsP1 : controller.graveCardsP2;
    showFullScreenImage(
    context,"image_card/spell_card/trip_tornado.png",
  );
  for (int i = 0; i < enemyField.length; i++) {
    final card = enemyField[i];
    if (card is SpellCardModel) {
      controller.onDead(i, player: isPlayer1 ? Player.player2 : Player.player1);
      enemyField[i] = null;
      if (kDebugMode) {
        print('Trip Tornado destroyed ${card.name} at index $i');
      }
    }
  }
  await Future.delayed(const Duration(milliseconds: 2000));
  final spellIndex = field.indexWhere((card) => card?.id == TripTornado.id);
  if (spellIndex != -1) {
    playerGrave.add(field[spellIndex]);
    field[spellIndex] = null;
    field.refresh();
  }

  enemyField.refresh();
}