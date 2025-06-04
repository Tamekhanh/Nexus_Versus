import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';

final GodHand = UnitCardModel(
  id: "unit003",
  name: "God Hand",
  description: "When this unit is summoned, it unleashes divine wrath — instantly destroying all enemy units with 1000 or less ATK. A harbinger of judgment from beyond the veil.",
  imageUrl: "image_card/unit_card/god_hand.png",
  level: 10,
  attackPower: 3000,
  healthPoints: 2000,
  onPlace: (context){},
  onAttack: (context) {},
  cardSpecial: Color(0xFF001157), // Brown color for God Hand
  series: ["Myth"],
);