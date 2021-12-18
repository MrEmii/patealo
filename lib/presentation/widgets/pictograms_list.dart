import 'package:flutter/material.dart';
import 'package:patealo/domain/entities/pictogram.dart';
import 'package:patealo/presentation/widgets/pictogram.dart';

class PictogramsList extends StatelessWidget {
  final List<Pictogram> pictograms;

  final String title;
  const PictogramsList({Key? key, required this.title, required this.pictograms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: Colors.black26,),
        Text(title, style: const TextStyle(color: Colors.black, fontSize: 20)),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 200,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemExtent: 200,
            shrinkWrap: false,
            scrollDirection: Axis.horizontal,
            itemCount: pictograms.length,
            itemBuilder: (context, index) {
              final pictogram = pictograms[index];
              return PictogramCard(pictogram: pictogram);
            },
          ),
        ),
      ],
    );
  }
}
