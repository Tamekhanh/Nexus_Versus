import 'package:audioplayers/audioplayers.dart';

class LoopPartsPlayer {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<String> _parts = [
    'sfx/Hokma_Battle_Theme_1.mp3',
    'sfx/Hokma_Battle_Theme_2.mp3',
    'sfx/Hokma_Battle_Theme_3.mp3',
  ];

  int _currentPartIndex = 0;

  LoopPartsPlayer() {
    _audioPlayer.onPlayerComplete.listen((_) => _playNextPart());
  }

  Future<void> start() async {
    _currentPartIndex = 0;
    await _playCurrentPart();
  }

  Future<void> _playCurrentPart() async {
    try {
      await _audioPlayer.play(
        AssetSource(_parts[_currentPartIndex]),
        volume: 0.1,
      );
    } catch (e) {
      print('Error playing background music: $e');
    }
  }

  Future<void> _playNextPart() async {
    _currentPartIndex = (_currentPartIndex + 1) % _parts.length;
    await _playCurrentPart();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }
}
