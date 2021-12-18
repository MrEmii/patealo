import 'package:flutter/material.dart';
import 'package:patealo/application/routes.dart';
import 'package:patealo/presentation/theme.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patealo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: Routes.routes,
    );
  }
}
