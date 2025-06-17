import 'package:flutter/material.dart';
import 'package:nexus_versus/app/modules/battle/controllers/battle_controller.dart';
import 'card_model.dart';

class UnitCardModel extends CardModel {
  int attackPower;
  int healthPoints;
  final Color cardSpecial;

  int currentHealthPoints;
  int currentAttackPower;

  int attackAttempt;
  int maxAttackAttempt;

  UnitCardModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.level,
    required this.attackPower,
    required this.healthPoints,
    super.series,
    this.cardSpecial = Colors.blueGrey,
    super.onPlace,
    super.onAttack,
    super.onDead,
    super.onEnemyPlace,
    super.onActive,
    this.maxAttackAttempt = 1,

  }): currentHealthPoints = healthPoints,
        currentAttackPower = attackPower,
        attackAttempt = maxAttackAttempt;

  factory UnitCardModel.fromJson(
      Map<String, dynamic> json, {
        void Function(BuildContext context)? onPlace,
        void Function(BuildContext context)? onAttack,
        void Function(BuildContext context, Player owner)? onDead,
        void Function(BuildContext context, Player owner)? onEnemyPlace,
        void Function(BuildContext context, Player owner)? onActive,
        Color cardSpecial = Colors.blueGrey,
      }) {
    return UnitCardModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      level: json['level'],
      series: List<String>.from(json['series'] ?? []),
      attackPower: json['attackPower'],
      healthPoints: json['healthPoints'],
      cardSpecial: cardSpecial,
      onPlace: onPlace,
      onAttack: onAttack,
      onDead: onDead,
      onEnemyPlace: onEnemyPlace,
      onActive: onActive,
      maxAttackAttempt: json['maxAttackAttempt'] ?? 1,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['attackPower'] = attackPower;
    json['healthPoints'] = healthPoints;
    json['type'] = 'unit';
    return json;
  }

  UnitCardModel toInBattle() {
    return UnitCardModel(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      level: level,
      attackPower: attackPower,
      healthPoints: healthPoints,
      series: series,
      cardSpecial: cardSpecial,
      onPlace: onPlace,
      onAttack: onAttack,
      onDead: onDead,
      onEnemyPlace: onEnemyPlace,
      onActive: onActive,
      maxAttackAttempt: maxAttackAttempt,
    );
  }
}
