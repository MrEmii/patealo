import 'package:flutter/material.dart';
import 'package:patealo/application/application.dart';
import 'package:patealo/application/repositories/chat_impl.dart';
import 'package:patealo/application/repositories/local_pictogram_impl.dart';
import 'package:patealo/application/repositories/pictograms_impl.dart';
import 'package:provider/provider.dart';

class Injector extends StatelessWidget {
  const Injector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PictogramsRepositoryImpl>(create: (_) => PictogramsRepositoryImpl()),
        ChangeNotifierProvider<PictrogramsLocalImpl>(create: (_) => PictrogramsLocalImpl()),
        ChangeNotifierProvider<ChatImpl>(create: (_) => ChatImpl()),
      ],
      child: const Application(),
    );
  }
}
