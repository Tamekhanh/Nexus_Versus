import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';

final RedCowBoy = UnitCardModel(
  id: "unit001",
  name: "Red Cowboy",
  description: "Quick Draw: when this unit is summoned, draw a card.",
  imageUrl: "image_card/unit_card/red_cowboy.png",
  level: 5,
  attackPower: 1000,
  healthPoints: 1000,
  onPlace: (context) {
    quickdraw("Red Cowboy");
  },
  onAttack: (context) {},
  cardSpecial: Colors.redAccent,
  series: ["Cowboy"],
);

void quickdraw(String caster) {
  debugPrint('$caster active skill Quick Draw - Draw a card');
}