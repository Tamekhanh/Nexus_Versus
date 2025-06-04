import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/card_model.dart';

class UnitCardModel extends CardModel{
  final int attackPower;
  final int healthPoints;
  final Color cardSpecial;
  void Function(BuildContext context)? onPlace;
  void Function(BuildContext context)? onAttack;
  void Function(BuildContext context)? onDead;

  UnitCardModel({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required int level,
    required this.attackPower,
    required this.healthPoints,
    List<String>? series,
    this.onPlace,
    this.onAttack,
    this.onDead,
    this.cardSpecial = Colors.blueGrey
  }): super(
    id: id,
    name: name,
    description: description,
    imageUrl: imageUrl,
    level: level,
    series: series,
  );

  factory UnitCardModel.fromJson(
      Map<String, dynamic> json,
      void Function(BuildContext context)? onPlace,
      void Function(BuildContext context)? onAttack,
      Color cardSpecial,
      void Function(BuildContext context)? onDead,
      ) {
    return UnitCardModel(
      id: json['id'],
      name: json['name'],
      attackPower: json['attackPower'],
      healthPoints: json['healthPoints'],
      description: json['description'],
      series: json['series'] != null ? List<String>.from(json['series']) : null,
      imageUrl: json['imageUrl'],
      level: json['level'],
      cardSpecial: cardSpecial,
      onPlace: onPlace,
      onAttack: onAttack,
      onDead: onDead,
    );
  }
}