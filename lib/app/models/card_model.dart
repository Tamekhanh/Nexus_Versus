import 'package:flutter/material.dart';

class CardModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int level;
  final List<String>? series;

  // Thêm các callback vào CardModel
  final void Function(BuildContext context)? onPlace;
  final void Function(BuildContext context)? onAttack;
  final void Function(BuildContext context)? onDead;

  CardModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.level,
    this.series,
    this.onPlace,
    this.onAttack,
    this.onDead,
  });

  factory CardModel.fromJson(
      Map<String, dynamic> json, {
        void Function(BuildContext context)? onPlace,
        void Function(BuildContext context)? onAttack,
        void Function(BuildContext context)? onDead,
      }) {
    return CardModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      level: json['level'],
      series: json['series'] != null ? List<String>.from(json['series']) : null,
      onPlace: onPlace,
      onAttack: onAttack,
      onDead: onDead,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'level': level,
      'series': series,
      // Callback thường không serialize nên không đưa vào JSON
    };
  }
}
