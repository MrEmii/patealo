mixin TTS {
  Future speak(String text, {Function(String text, int startOffset, int endOffset, String word)? progress});

  Future stop();

  Future pause();
}
