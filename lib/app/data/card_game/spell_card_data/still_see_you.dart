import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';
import 'package:nexus_versus/app/widgets/full_screen_image_overlay.dart';

final StillSeeYou = SpellCardModel(
  id: "spell003",
  name: "They Still See You",
  description: "In the shadows of the past, they still watch. This spell allows you to summon a unit from your graveyard, bringing back a fallen ally to fight once more.",
  imageUrl: "image_card/spell_card/they_can_see_you.png",
  level: 10,
  onPlace: (context) {
    // showFullScreenImage(context,"summon_effect/bigbird.png");
    showFullScreenImage(context,"image_card/spell_card/they_can_see_you.png");
  },
  onAttack: (context) {},
  cardSpecial: Color(0xFF001157),
  series: ["Myth"],
);

void showFullScreenImage(BuildContext context, String imagePath, {Duration duration = const Duration(seconds: 1)}) {
  final overlay = Overlay.of(context);

  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => FullScreenImageOverlay(
      imagePath: imagePath,
      duration: duration,
      onFinish: () => overlayEntry.remove(),
    ),
  );

  overlay.insert(overlayEntry);
}
