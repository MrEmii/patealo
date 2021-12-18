import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:patealo/application/services/tts_service.dart';
import 'package:patealo/domain/entities/pictogram.dart';

class PictogramCard extends StatelessWidget {
  final Pictogram pictogram;

  const PictogramCard({Key? key, required this.pictogram}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.all(Radius.circular(10)), border: Border.all(color: Colors.black12), boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: Offset(2, 2),
        ),
      ]),
      child: GestureDetector(
        onTap: () {
          TTSService.tts.speak(pictogram.keywords[0].keyword);
        },
        onDoubleTap: () {
          if (pictogram.categories.contains('qualifying adjective')) {
            TTSService.tts.speak('Yo estoy ${pictogram.keywords[0].keyword}');
          } else if (pictogram.categories.contains('verb')) {
            TTSService.tts.speak('voy a ${pictogram.keywords[0].keyword}');
          } else if (pictogram.categories.contains('noun')) {
            TTSService.tts.speak('Yo soy ${pictogram.keywords[0].keyword}');
          } else if (pictogram.categories.contains('human response')) {
            TTSService.tts.speak('Me dió ${pictogram.keywords[0].keyword}');
          } else if (pictogram.categories.contains('human value')) {
            TTSService.tts.speak('Quiero ${pictogram.keywords[0].keyword}');
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: pictogram.url,
              width: 150,
            ),
            Text(pictogram.keywords[0].keyword, style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
