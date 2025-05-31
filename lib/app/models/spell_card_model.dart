import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/card_model.dart';

class SpellCardModel extends CardModel {
  final Color cardSpecial;
  final VoidCallback? onPlace;
  final VoidCallback? onAttack;
  final VoidCallback? onDead;

  SpellCardModel({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required int level,
    List<String>? series,
    this.cardSpecial = Colors.blueGrey,
    this.onPlace,
    this.onAttack,
    this.onDead,
  }) : super(
    id: id,
    name: name,
    description: description,
    imageUrl: imageUrl,
    level: level,
    series: series,
  );

  factory SpellCardModel.fromJson(
      Map<String, dynamic> json,
      VoidCallback onPlace,
      VoidCallback onAttack,
      Color cardSpecial,
      VoidCallback onDead,
      ) {
    return SpellCardModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      level: json['level'],
      series: json['series'] != null ? List<String>.from(json['series']) : null,
      cardSpecial: cardSpecial,
      onPlace: onPlace,
      onAttack: onAttack,
      onDead: onDead,
    );
  }
}
