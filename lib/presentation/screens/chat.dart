import 'package:flutter/material.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:patealo/application/repositories/chat_impl.dart';
import 'package:patealo/domain/model/message.dart';
import 'package:patealo/presentation/theme.dart';
import 'package:patealo/presentation/widgets/chat_bubble.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  double _keyboardHeight = 0;

  bool _wouldTalk = false;

  late ChatImpl chat;

  late final SpeechRecognition _speech;

  bool isAvailableSpeech = false;

  bool _isListening = false;

  String transcription = '';

  @override
  void initState() {
    super.initState();
    chat = Provider.of<ChatImpl>(context, listen: false);
    _speech = SpeechRecognition();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      _speech.setAvailabilityHandler((bool result) => setState(() => isAvailableSpeech = result));

      _speech.setRecognitionStartedHandler(_onStartListening);

      _speech.setRecognitionResultHandler((String text) => setState(() => _textController.text = text));

      _speech.setRecognitionCompleteHandler(_onComplete);

      await _speech.activate('es_ES');

      _focusNode.addListener(_onFocusInput);
    });
  }

  _onStartListening() {
    _isListening = true;
    _textController.clear();
    setState(() {});
  }

  _onComplete(String complete) {
    _speech.stop();
    _isListening = false;
    setState(() {
      _textController.clear();
    });
    chat.addMessage(Message(message: complete, isMine: true));
  }

  _onFocusInput() {
    setState(() {
      if (_focusNode.hasFocus) {
        _wouldTalk = false;
        _keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
      }
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusInput);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Message> messages = context.watch<ChatImpl>().messages;
    if (MediaQuery.of(context).viewInsets.bottom >= _keyboardHeight) {
      setState(() {
        _keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: true,
        actions: [
          if (messages.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                chat.clear();
              },
            ),
        ],
      ),
      body: SizedBox.fromSize(
        size: size,
        child: Flex(
          mainAxisSize: MainAxisSize.max,
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 2,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return ChatBubble(message: message);
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                margin: const EdgeInsets.only(bottom: 16),
                width: size.width * .7,
                decoration: const BoxDecoration(color: AppTheme.primaryColor, borderRadius: BorderRadius.all(Radius.circular(10)), boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 2,
                    spreadRadius: 1,
                    offset: Offset(0, 0),
                  ),
                ]),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        autofocus: true,
                        focusNode: _focusNode,
                        controller: _textController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Escribi un mensaje',
                          hintStyle: TextStyle(color: Colors.white30),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      color: Colors.white,
                      onPressed: () {
                        final message = _textController.text;
                        _textController.clear();
                        FocusScope.of(context).unfocus();
                        chat.addMessage(Message(message: message, isMine: true));
                      },
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(size.width * .48, 70),
                      primary: Colors.red[400],
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        _wouldTalk = true;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_isListening ? 'Escuchando...' : 'Escuchar', style: TextStyle(color: Colors.red[100], fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Icon(Icons.hearing, color: Colors.red[100]),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(size.width * .48, 70),
                      primary: Colors.cyan[400],
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                      ),
                    ),
                    onPressed: () {
                      _focusNode.requestFocus();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.text_fields, color: Colors.blue[900]),
                        const SizedBox(width: 8),
                        Text('Hablar', style: TextStyle(color: Colors.blue[900], fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (_wouldTalk)
              GestureDetector(
                onTap: () async {
                  if(_isListening) {
                    await _speech.stop();
                    _isListening = false;
                  } else {
                     await _speech.listen();
                  }
                },
                child: Container(
                  width: size.width,
                  height: _keyboardHeight,
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _isListening
                            ? [
                                const SizedBox(height: 20),
                                const Text('Escuchando...', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 20),
                                if (_textController.text.isNotEmpty) Text(_textController.text, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 20),
                                const CircularProgressIndicator(),
                              ]
                            : [
                                const Text('Toca para empezar', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 20),
                                const Icon(Icons.mic, color: Colors.white, size: 40),
                              ]),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
