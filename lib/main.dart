import 'package:flutter/widgets.dart';
import 'package:patealo/application/injector.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const Injector()
  );
}