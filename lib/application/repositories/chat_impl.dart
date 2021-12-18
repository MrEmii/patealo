import 'package:flutter/widgets.dart';
import 'package:patealo/application/services/tts_service.dart';
import 'package:patealo/domain/model/message.dart';
import 'package:patealo/domain/repositories/chat_repository.dart';

class ChatImpl extends ChangeNotifier with ChatRepository {

  final List<Message> _messages = [];


  get messages => _messages;

  @override
  Future addMessage(Message message) async {
    //check if the last message is the same as the new one
    if (_messages.isNotEmpty && _messages.last.message == message.message) {
      return;
    }
    _messages.add(message);

    TTSService.tts.speak(message.message);
    notifyListeners();
  }

  @override
  clear() {
    _messages.clear();
    notifyListeners();
  }

  @override
  Future<Message> speechToText() async {
    return Message(message: '', isMine: false);
  }

}