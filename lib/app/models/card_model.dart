import 'package:flutter/material.dart';

class CardModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int level;
  final List<String>? series;

  CardModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.level,
    this.series,
  });

  factory CardModel.fromJson(Map<String, dynamic> json,) {
    return CardModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      level: json['level'],
      series: json['series'] != null ? List<String>.from(json['series']) : null,
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
    };
  }
}