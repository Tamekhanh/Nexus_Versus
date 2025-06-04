import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';

final BlackCrow = UnitCardModel(
  id: "unit002",
  name: "Crow Soldier",
  description: "When this unit dead, it deals 500 damage to the enemy.",
  imageUrl: "image_card/unit_card/black_crow.png",
  level: 4,
  attackPower: 2000,
  healthPoints: 1000,
  onPlace: (context){},
  onAttack: (context) {},
  cardSpecial: Colors.grey,
  series: ["Crow"],
);