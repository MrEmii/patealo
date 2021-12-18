import 'package:flutter_tts/flutter_tts.dart';
import 'package:patealo/domain/abstracts/tts.dart';

class TTSService with TTS {
  TTSService._();

  static final TTSService tts = TTSService._();

  final FlutterTts _flutterTts = FlutterTts();

  Future init() async {
    bool isAvailable = await _flutterTts.isLanguageAvailable("es-MX");

    if (isAvailable) {
      await _flutterTts.setLanguage("es-MX");

      await _flutterTts.setSpeechRate(.5);

      await _flutterTts.setVolume(1.0);

      await _flutterTts.setPitch(1.0);
    }
  }

  @override
  Future pause() async {
    await _flutterTts.pause();
  }

  @override
  Future stop() async {
    await _flutterTts.stop();
  }

  @override
  Future speak(String text, {void Function(String text, int start, int end, String word)? progress}) async {
    if (progress != null) {
      _flutterTts.setProgressHandler(progress);
    }
    await _flutterTts.speak(text);
  }
}
