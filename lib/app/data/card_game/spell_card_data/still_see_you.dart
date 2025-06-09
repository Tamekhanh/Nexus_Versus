import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';
import 'package:nexus_versus/app/widgets/full_screen_image_text_shake.dart';

final StillSeeYou = SpellCardModel(
  id: "spell003",
  name: "They Still See You",
  description: "In the shadows of the past, they still watch. This spell allows you to summon a unit from your graveyard, bringing back a fallen ally to fight once more.",
  imageUrl: "image_card/spell_card/they_can_see_you.png",
  level: 13,
  onPlace: (context) => onPlace(context),
  onAttack: (context) {

  },
  cardSpecial: Color(0xFF001157),
  series: ["Myth"],
);

void onPlace(BuildContext context) {
  // This function can be used to handle any additional logic when the card is placed
  // For example, you might want to trigger an animation or update the game state

  debugPrint("Spell card 'They Still See You' has been placed.");
  showFullScreenImage(
    context,"image_card/spell_card/they_can_see_you.png",
    text: Text(
        "They Still See You",
        style: TextStyle(
          fontSize: MediaQuery.sizeOf(context).width * 0.075,
          fontWeight: FontWeight.w900,
          fontFamily: 'Cinzel', // Gothic style, nên import vào pubspec.yaml
          letterSpacing: 2.0,
          color: Colors.redAccent.shade100,
          shadows: [
            Shadow(
              blurRadius: 4,
              color: Colors.black87,
              offset: Offset(2, 2),
            ),
            Shadow(
              blurRadius: 10,
              color: Colors.redAccent.withOpacity(0.7),
              offset: Offset(0, 0),
            ),
          ],
        )
    ),
  );
}
