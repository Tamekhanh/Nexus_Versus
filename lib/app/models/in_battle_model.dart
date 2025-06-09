import 'dart:ui';

import 'package:nexus_versus/app/models/unit_card_model.dart';
import 'package:flutter/material.dart';

class InBattleModel extends UnitCardModel {
  final int currentHealthPoints;
  final int currentAttackPower;
  final int attemt = 1;

  InBattleModel({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required int level,
    required int attackPower,
    required int healthPoints,
    this.currentHealthPoints = 0,
    this.currentAttackPower = 0,
    List<String>? series,
    void Function(BuildContext context)? onPlace,
    void Function(BuildContext context)? onAttack,
    void Function(BuildContext context)? onDead,
    Color cardSpecial = Colors.blueGrey,
  }) : super(
          id: id,
          name: name,
          description: description,
          imageUrl: imageUrl,
          level: level,
          attackPower: attackPower,
          healthPoints: healthPoints,
          series: series,
          onPlace: onPlace,
          onAttack: onAttack,
          onDead: onDead,
          cardSpecial: cardSpecial,
        );
}

extension UnitCardToInBattle on UnitCardModel {
  InBattleModel toInBattle() {
    return InBattleModel(
      id: this.id,
      name: this.name,
      description: this.description,
      imageUrl: this.imageUrl,
      level: this.level,
      attackPower: this.attackPower,
      healthPoints: this.healthPoints,
      currentHealthPoints: this.healthPoints,
      currentAttackPower: this.attackPower,
      series: this.series,
      onPlace: this.onPlace,
      onAttack: this.onAttack,
      onDead: this.onDead,
      cardSpecial: this.cardSpecial,
    );
  }
}