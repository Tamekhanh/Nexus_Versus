import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';

final WarAndPeace = SpellCardModel(
  id: "spell002",
  name: "Wings of War, Petals of Peace",
  description: "Forged in times of chaos, this spell symbolizes the delicate balance between destruction and harmony. When this spell is activated, increases the ATK of all allies by 1000 until this card is destroyed. " ,
  imageUrl: "image_card/spell_card/war_peace.png",
  level: 10,
  onPlace: (context){},
  onAttack: (context) {},
  series: ["Crow"],
);