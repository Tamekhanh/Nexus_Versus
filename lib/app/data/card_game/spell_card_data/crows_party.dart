import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';

final CrowsParty = SpellCardModel(
  id: "unit002",
  name: "Crow's Party",
  description: "You're invited to the Crow's party. When this spell is activated, increases the ATK of all allies by 500 for one turn.",
  imageUrl: "image_card/spell_card/crows_party.png",
  level: 6,
  onPlace: (){},
  onAttack: () {},
  cardSpecial: Colors.grey,
  series: ["Crow"],
);