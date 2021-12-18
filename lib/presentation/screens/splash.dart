import 'package:flutter/material.dart';
import 'package:patealo/application/repositories/pictograms_impl.dart';
import 'package:patealo/application/services/tts_service.dart';
import 'package:provider/src/provider.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late PictogramsRepositoryImpl _pictogramsRepository;

  @override
  void initState() {
    super.initState();
    _pictogramsRepository = PictogramsRepositoryImpl.of(context);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await _pictogramsRepository.getPictograms();
      await TTSService.tts.init();

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final total = context.watch<PictogramsRepositoryImpl>().pictograms.length;

    return Scaffold(
      body: SizedBox.fromSize(
        size: size,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('PÁTEALO', style: textTheme.headline4!.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text('$total pictrogramas', style: textTheme.headline6!.copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(height: 50),
            const CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: size.width,
                height: size.height * 0.2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'The pictographic symbols used are the property of the Government of Aragón and have been created by Sergio Palao for ARASAAC (http://www.arasaac.org), that distributes them under Creative Commons License BY-NC-SA. Pictograms author: Sergio Palao. Origin: ARASAAC (http://www.arasaac.org). License: CC (BY-NC-SA). Owner: Government of Aragon (Spain)',
                    style: textTheme.subtitle2!.copyWith(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
