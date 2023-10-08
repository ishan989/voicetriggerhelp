import 'package:speech_to_text/speech_to_text.dart';

class SpeechApi {
  static final SpeechToText _speech = SpeechToText();

  static Future<bool> startListening({
    required Function(String text) onResult,
  }) async {
    final isAvailable = await _speech.initialize();

    if (isAvailable) {
      _speech.listen(
        onResult: (result) {
          final recognizedWords = result.recognizedWords;
          onResult(recognizedWords);
        },
      );
    }

    return isAvailable;
  }

  static void stopListening() {
    if (_speech.isListening) {
      _speech.stop();
    }
  }
}