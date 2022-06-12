import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pisale/widgets/fondo_circular.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                child: RotationTransition(
              turns: AlwaysStoppedAnimation(-15 / 360),
              child: Opacity(
                  opacity: 0.4,
                  child: Image.asset('assets/coche.png', width: 100)),
            )),
            FondoCircular(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 120,
                ),
              ],
            ),
            Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: size.height * 0.45,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MenuButton(
                              Colors.red,
                              () {
                                Navigator.pushNamed(context, 'rutas');
                              },
                              'Rutas',
                            ),
                            MenuButton(
                              Colors.yellow.shade600,
                              () {
                                Navigator.pushNamed(context, 'random_test');
                              },
                              'Tests aleatorios',
                            ),
                            MenuButton(
                              Colors.green,
                              () {
                                Navigator.pushNamed(context, 'themes');
                              },
                              'Hacer test',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      height: size.height * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final Color color;
  final dynamic function;
  final String text;

  MenuButton(this.color, this.function, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: MaterialButton(
          onPressed: function,
          color: color,
          minWidth: 240,
          height: 60,
          child: Text(
            text,
            style: GoogleFonts.getFont(
              'Cairo',
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
