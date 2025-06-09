import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nexus_versus/app/data/card_game/spell_card_data/still_see_you.dart';
import 'package:nexus_versus/app/data/card_game/unit_card_data/black_crow.dart';
import 'package:nexus_versus/app/data/debug/debug_data.dart';
import 'package:nexus_versus/app/models/card_model.dart';
import 'package:nexus_versus/app/models/in_battle_model.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';

class DebugBuildController extends GetxController {
  //TODO: Implement DebugBuildController
  var hoveredCardIndex = (-1).obs;
  var selectedCardIndex = (-1).obs;
  final count = 0.obs;
  final loopPlayer = LoopPartsPlayer();

  RxList<CardModel?> cardList = <CardModel?>[].obs;

  var onFieldP2 = <CardModel?>[].obs;
  var onFieldP1 = <CardModel?>[
    BlackCrow, null, null, null, null, // Hàng 1-5: UnitCard
    null, null, StillSeeYou, null, null, // Hàng 6-10: SpellCard
  ].obs;

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playPlaceCardSound(String local) async {
    await _audioPlayer.play(
        AssetSource(local),
      volume: 0.5
    );
  }

  @override
  void onInit() {
    super.onInit();
    cardList.value = debugData.entries
        .expand((entry) => List.generate(entry.value, (_) => entry.key))
        .toList();
    onFieldP2.value = List.filled(10, null);
  }

  void placeCardonFieldP2(int fieldIndex, BuildContext context) {
    final selectedIndex = selectedCardIndex.value;
    if (selectedIndex == -1 || onFieldP2[fieldIndex] != null) return;

    final selected = cardList[selectedIndex];
    if (selected == null) return;

    // Kiểm tra đúng loại thẻ cho từng hàng
    if (fieldIndex <= 4 && selected is! UnitCardModel) return; // Hàng UnitCard
    if (fieldIndex >= 5 && selected is! SpellCardModel) return; // Hàng SpellCard
    if (selected is UnitCardModel) {
      final placedCard = selected.toInBattle(); // OK vì là UnitCardModel
      onFieldP2[fieldIndex] = placedCard;
      selected.onPlace?.call(context);
    } else if (selected is SpellCardModel) {
      onFieldP2[fieldIndex] = selected; // Không cần gọi toInBattle nếu SpellCardModel không kế thừa
      selected.onPlace?.call(context);
    }
    selectedCardIndex.value = -1;

    onFieldP2.refresh();
    cardList.refresh();

    _playPlaceCardSound('sfx/Card_Apply.mp3');

    if (selected is SpellCardModel && selected.onPlace != null) {
      selected.onPlace!(context);
    } else if (selected is UnitCardModel && selected.onPlace != null) {
      selected.onPlace!(context);
    }
  }

  void selectCard(int index) {
    selectedCardIndex.value = index;
    _playPlaceCardSound('sfx/Card_Select.mp3');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    loopPlayer.stop();
  }

  void increment() => count.value++;
}


class LoopPartsPlayer {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<String> _parts = [
    'sfx/Hokma_Battle_Theme_1.mp3',
    'sfx/Hokma_Battle_Theme_2.mp3',
    'sfx/Hokma_Battle_Theme_3.mp3',
  ];

  int _currentPartIndex = 0;

  LoopPartsPlayer() {
    // Lắng nghe event khi âm thanh kết thúc
    _audioPlayer.onPlayerComplete.listen((event) {
      _playNextPart();
    });
  }

  Future<void> start() async {
    _currentPartIndex = 0;
    await _playCurrentPart();
  }

  Future<void> _playCurrentPart() async {
    await _audioPlayer.play(
        AssetSource(_parts[_currentPartIndex]),
      volume: 0.3
    );
  }

  Future<void> _playNextPart() async {
    _currentPartIndex++;
    if (_currentPartIndex >= _parts.length) {
      _currentPartIndex = 0; // quay về phần đầu
    }
    await _playCurrentPart();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }
}