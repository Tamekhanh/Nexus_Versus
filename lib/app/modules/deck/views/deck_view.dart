import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/deck_controller.dart';

class DeckView extends GetView<DeckController> {
  const DeckView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeckView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DeckView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
