import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nexus_versus/app/models/card_model.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';
import 'package:nexus_versus/app/widgets/full_screen_image_text_shake.dart';

import '../../../modules/battle/controllers/battle_controller.dart';
import '../../../widgets/card_revive_effect.dart';

final StillSeeYou = SpellCardModel(
  id: "spell003",
  name: "They Still See You",
  description: "In the shadows of the past, they still watch. This spell allows you to summon a unit from your graveyard recently to your hand, bringing back a fallen ally to fight once more.",
  imageUrl: "image_card/spell_card/they_can_see_you.png",
  level: 13,
  onPlace: (context) => onPlace(context),
  onAttack: (context) {

  },
  cardSpecial: Color(0xFF001157),
  series: ["Myth"],
);

Future<void> onPlace(BuildContext context) async {
  // This function can be used to handle any additional logic when the card is placed
  // For example, you might want to trigger an animation or update the game state
  final controller = Get.find<BattleController>();
  final isPlayer1 = controller.currentTurn.value == Player.player1;
  final field = isPlayer1 ? controller.onFieldP1 : controller.onFieldP2;
  final playerGrave = isPlayer1 ? controller.graveCardsP1 : controller.graveCardsP2;
  final playerHand = controller.getHand(controller.currentTurn.value);
  showFullScreenImage(
    context,"image_card/spell_card/they_can_see_you.png",
  );

  try {
    if (!playerGrave.isEmpty) {
      final lastUnit = playerGrave.lastWhere(
            (card) => card is UnitCardModel,
        orElse: () => null as CardModel?,
      );

      if (lastUnit != null && lastUnit is UnitCardModel) {
        playerGrave.remove(lastUnit);
        playerHand.add(lastUnit);
        playerGrave.refresh();
        playerHand.refresh();

        if (kDebugMode) {
          print('Spell effect: Summoned ${lastUnit.name} from *your own* graveyard to hand.');
        };
        await Future.delayed(const Duration(milliseconds: 2000));
      } else {
        if (kDebugMode) {
          print('Spell effect: No unit card found in your own graveyard.');
        }
      }
      final spellIndex = field.indexWhere((card) => card?.id == StillSeeYou.id);
      if (spellIndex != -1) {
        playerGrave.add(field[spellIndex]);
        field[spellIndex] = null;
        field.refresh();
      }
    } else {
      if (kDebugMode) {
        print('Spell effect: Your graveyard is empty.');
      }
    }
    await Future.delayed(const Duration(milliseconds: 2000));
    final spellIndex = field.indexWhere((card) => card?.id == StillSeeYou.id);
    if (spellIndex != -1) {
      playerGrave.add(field[spellIndex]);
      field[spellIndex] = null;
      field.refresh();
    }
  } catch (e) {
    debugPrint("Error while summoning a unit from the graveyard: $e");
  }
}
