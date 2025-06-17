import 'package:flutter/material.dart';
import 'package:nexus_versus/app/modules/battle/controllers/battle_controller.dart';
import 'card_model.dart';

class SpellCardModel extends CardModel {
  final Color cardSpecial;
  final int activeTurn;

  SpellCardModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.level,
    super.series,
    this.cardSpecial = Colors.blueGrey,
    super.onPlace,
    super.onAttack,
    super.onDead,
    super.onEnemyPlace,
    super.onActive,
    this.activeTurn = 0,
  });

  factory SpellCardModel.fromJson(
      Map<String, dynamic> json, {
        void Function(BuildContext context)? onPlace,
        void Function(BuildContext context)? onAttack,
        void Function(BuildContext context, Player owner)? onDead,
        void Function(BuildContext context, Player owner)? onEnemyPlace,
        void Function(BuildContext context, Player owner)? onActive,
        Color cardSpecial = Colors.blueGrey,
      }) {
    return SpellCardModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      level: json['level'],
      series: List<String>.from(json['series'] ?? []),
      cardSpecial: cardSpecial,
      onPlace: onPlace,
      onAttack: onAttack,
      onDead: onDead,
      onEnemyPlace: onEnemyPlace,
      onActive: onActive,
      activeTurn: json['activeTurn'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['type'] = 'spell';
    return json;
  }
}
