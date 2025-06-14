import 'package:flutter/material.dart';
import 'card_model.dart';

class UnitCardModel extends CardModel {
  int attackPower;
  int healthPoints;
  final Color cardSpecial;

  int currentHealthPoints;
  int currentAttackPower;

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
  }): currentHealthPoints = healthPoints,
        currentAttackPower = attackPower;

  factory UnitCardModel.fromJson(
      Map<String, dynamic> json, {
        void Function(BuildContext context)? onPlace,
        void Function(BuildContext context)? onAttack,
        void Function(BuildContext context)? onDead,
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
    );
  }
}
