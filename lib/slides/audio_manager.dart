import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  // ignore: deprecated_member_use
  final Soundpool _soundPool = Soundpool();

  // Constructor privado para el singleton
  AudioManager._internal();

  factory AudioManager() {
    return _instance;
  }

  Future<int> loadSound(String soundPath) async {
    final ByteData soundData = await rootBundle.load(soundPath);
    return await _soundPool.load(soundData);
  }

  Future<void> playSound(int soundId) async {
    await _soundPool.play(soundId);
  }

  Future<void> stopSound(int soundId) async {
    await _soundPool.stop(soundId);
  }

  void dispose() {
    _soundPool.dispose();
  }
}
