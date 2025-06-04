import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/card_model.dart';

class SpellCardModel extends CardModel {
  final Color cardSpecial;
  void Function(BuildContext context)? onPlace;
  void Function(BuildContext context)? onAttack;
  void Function(BuildContext context)? onDead;

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
      void Function(BuildContext context)? onPlace,
      void Function(BuildContext context)? onAttack,
      Color cardSpecial,
      void Function(BuildContext context)? onDead,
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

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['type'] = 'spell';
    return json;
  }
}
