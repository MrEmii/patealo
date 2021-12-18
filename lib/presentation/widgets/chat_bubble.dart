import 'package:flutter/material.dart';
import 'package:patealo/application/services/tts_service.dart';
import 'package:patealo/domain/model/message.dart';

class ChatBubble extends StatefulWidget {
  final Message message;

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        TTSService.tts.speak(widget.message.message);
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, 1 - _controller.value),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.5,
              ),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: widget.message.isMine ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.message.message,
                style: TextStyle(
                  color: widget.message.isMine ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
