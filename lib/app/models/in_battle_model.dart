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
    VoidCallback? onPlace,
    VoidCallback? onAttack,
    VoidCallback? onDead,
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