import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: wait3seconds(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Image.asset('assets/logo.png'),
                  ),
                  Image.asset(
                    'assets/torre.png',
                    width: 60,
                  ),
                ],
              ),
            );
          }

          Future.microtask(() {
            Navigator.pushReplacementNamed(context, 'login');
          });
          return Container();
        },
      )),
    );
  }

  Future wait3seconds(BuildContext context) async {
    await Future.delayed(Duration(seconds: 4));
    Navigator.pushReplacementNamed(context, 'home');
  }
}
