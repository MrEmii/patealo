import 'package:flutter/material.dart';
import 'package:patealo/presentation/widgets/home_button.dart';
import 'package:patealo/presentation/widgets/wave_painter.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox.fromSize(
        size: size,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                painter: WavePainter(),
                size: Size(size.width, 200),
              )
            ),
            SafeArea(
              top: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 50),
                  Text('PÁTEALO', style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      children: [
                        HomeButton(
                          icon: Icons.chat_bubble_outline,
                          text: 'Chat',
                          onTap: () => Navigator.pushNamed(context, '/chat'),
                        ),
                        HomeButton(
                          icon: Icons.image_outlined,
                          text: 'Pictogramas',
                          onTap: () => Navigator.pushNamed(context, '/pictograms'),
                        ),
                        HomeButton(
                          icon: Icons.shortcut_outlined,
                          text: 'Atajos',
                          onTap: () => Navigator.pushNamed(context, '/shortcuts'),
                        ),
                        HomeButton(
                          icon: Icons.settings_outlined,
                          text: 'Configuración',
                          onTap: () => Navigator.pushNamed(context, '/settings'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
