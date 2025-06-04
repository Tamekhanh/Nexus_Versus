import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';

final CrowsParty = SpellCardModel(
  id: "spell001",
  name: "Crow's Party",
  description: "The crows gather under a moonless sky. When this spell is cast, all allied units gain +500 ATK for one turn — a deadly dance begins.",
  imageUrl: "image_card/spell_card/crows_party.png",
  level: 6,
  onPlace: (context){},
  onAttack: (context) {},
  cardSpecial: Colors.grey,
  series: ["Crow"],
);