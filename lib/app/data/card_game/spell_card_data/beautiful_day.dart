import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';

final BeautifulDay = SpellCardModel(
  id: "spell004",
  name: "Blessing of the Morning",
  description: "As the first light of dawn touches the land, a gentle warmth fills your soul. "
      "This spell grants you the blessing of clarity and preparation—draw two additional cards from your deck and ready yourself for the trials ahead.",
  imageUrl: "image_card/spell_card/beautiful_day.png",
  level: 12,
  onPlace: (context){},
  onAttack: (context) {},
  cardSpecial: Color(0xFFDFDFDF),
  series: ["Yokai"],
);