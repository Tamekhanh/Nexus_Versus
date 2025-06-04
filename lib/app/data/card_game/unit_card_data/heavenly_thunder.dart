import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';

final HeavenlyThunder = UnitCardModel(
  id: "unit004",
  name: "Heavenly Thunder",
  description: "Upon being summoned, a divine tempest is unleashed, striking all enemy units for 1000 damage. "
      "Forged from the wrath of the skies, it brings judgment from above.",
  imageUrl: "image_card/unit_card/heavenly_thunder.png",
  level: 6,
  attackPower: 1500,
  healthPoints: 2000,
  onPlace: (context){},
  onAttack: (context) {},
  cardSpecial: Color(0xFF001157), // Brown color for God Hand
  series: ["Myth"],
);