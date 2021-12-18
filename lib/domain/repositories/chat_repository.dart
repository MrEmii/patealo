import 'package:patealo/domain/model/message.dart';

mixin ChatRepository {

  Future addMessage(Message message);

  Future<Message> speechToText();

  clear();

}