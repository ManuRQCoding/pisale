import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pisale/firebase_options.dart';
import 'package:pisale/pages/home_page.dart';
import 'package:pisale/pages/login_page.dart';
import 'package:pisale/pages/random_tests/random_tests_page.dart';
import 'package:pisale/pages/rutas/ruta_detail_page.dart';
import 'package:pisale/pages/tests/questions_page.dart';
import 'package:pisale/pages/tests/results_page.dart';
import 'package:pisale/pages/rutas/rutas_page.dart';
import 'package:pisale/pages/splash_page.dart';
import 'package:pisale/pages/tests/tests_page.dart';
import 'package:pisale/pages/tests/themes_page.dart';
import 'package:pisale/providers/auth_prov.dart';
import 'package:pisale/providers/test_provider.dart';
import 'package:provider/provider.dart';

import 'propeties.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TestProvider()),
        ChangeNotifierProvider(create: (_) => AuthProv())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Color(palette['primary']!),
            onPrimary: Colors.white,
            secondary: Color(palette['secondary']!),
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.white,
            background: Color(palette['background']!),
            onBackground: Colors.white,
            surface: Color(palette['background']!),
            onSurface: Color(palette['background']!),
            tertiary: Color(palette['tertiary']!),
          ),
          primaryColor: Color(palette['primary']!),
        ),
        routes: {
          'login': (context) => LoginPage(),
          'home': (context) => HomePage(),
          'splash': (context) => SplashPage(),
          'themes': (context) => ThemesPage(),
          'tests': (context) => TestsPage(),
          'questions': (context) => QuestionsPage(),
          'results': (context) => ResultsPage(),
          'rutas': (context) => RutasPage(),
          'ruta_detail': (context) => RutaDetail(),
          'random_test': (context) => RandomTests(),
        },
        initialRoute: 'login',
      ),
    );
  }
}
