import 'package:flutter/material.dart';
import 'package:patealo/application/repositories/pictograms_impl.dart';
import 'package:patealo/presentation/theme.dart';
import 'package:patealo/presentation/widgets/pictograms_list.dart';
import 'package:provider/src/provider.dart';

class Pictograms extends StatefulWidget {
  const Pictograms({Key? key}) : super(key: key);

  @override
  State<Pictograms> createState() => _PictogramsState();
}

class _PictogramsState extends State<Pictograms> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late final AnimationController _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

  bool isScrooleable = true;

  @override
  Widget build(BuildContext context) {
    final pictograms = context.watch<PictogramsRepositoryImpl>().pictograms;

    final feelings = pictograms.where((pictogram) {
      return pictogram.categories.contains('feeling') && pictogram.categories.contains('qualifying adjective');
    }).toList();

    final body = pictograms.where((pictogram) {
      return pictogram.categories.contains('human anatomy');
    }).toList();

    final actions = pictograms.where((pictogram) {
      return pictogram.categories.contains('verb');
    }).toList();

    final emergency = pictograms.where((pictogram) {
      return pictogram.categories.contains('public administration') || pictogram.categories.contains('emergency') || pictogram.categories.contains('health personnel') || pictogram.categories.contains('health care') || pictogram.categories.contains('sanitary professional');
    }).toList();

    final foods = pictograms.where((pictogram) {
      return pictogram.tags.contains('food') && pictogram.categories.contains('gastronomy');
    }).toList();

    final animals = pictograms.where((pictogram) {
      return pictogram.tags.contains('animal');
    }).toList();

    final family = pictograms.where((pictogram) {
      return pictogram.tags.contains('family');
    }).toList();

    final clothes = pictograms.where((pictogram) {
      return pictogram.tags.contains('clothes');
    }).toList();

    final places = pictograms.where((pictogram) {
      return pictogram.tags.contains('place');
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pictogramas'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            onPressed: () {
              //Mostrar dialog dando creditos a ARASAAC
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'ARASAAC',
                      style: TextStyle(color: Colors.black),
                    ),
                    content: const Text(
                      'The pictographic symbols used are the property of the Government of Aragón and have been created by Sergio Palao for ARASAAC (http://www.arasaac.org), that distributes them under Creative Commons License BY-NC-SA. Pictograms author: Sergio Palao. Origin: ARASAAC (http://www.arasaac.org). License: CC (BY-NC-SA). Owner: Government of Aragon (Spain)',
                      style: TextStyle(color: Colors.black45),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Cerrar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) {
            return AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _animationController,
            );
          },
        ),
        onPressed: () {
          if(_animationController.value == 0) {
            _animationController.forward();
            setState(() {
              isScrooleable = false;
            });
          } else {
            _animationController.reverse();
            setState(() {
              isScrooleable = true;
            });
          }
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        controller: _scrollController,
        physics: isScrooleable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            PictogramsList(title: 'Sentimientos', pictograms: feelings),
            PictogramsList(title: 'Cuerpo', pictograms: body),
            PictogramsList(title: 'Acciones', pictograms: actions),
            PictogramsList(title: 'Emergencias', pictograms: emergency),
            PictogramsList(title: 'Comidas', pictograms: foods),
            PictogramsList(title: 'Animal', pictograms: animals),
            PictogramsList(title: 'Familia', pictograms: family),
            PictogramsList(title: 'Vestimenta', pictograms: clothes),
            PictogramsList(title: 'Lugares', pictograms: places),
          ],
        ),
      ),
    );
  }
}
