import 'package:flutter/material.dart';
import 'package:pisale/providers/auth_prov.dart';
import 'package:pisale/widgets/custom_elevated_button.dart';
import 'package:pisale/widgets/password_input.dart';
import 'package:pisale/widgets/user_input.dart';
import 'package:provider/provider.dart';

import '../propeties.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(size.width);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(palette['background']!),
      body: Stack(
        children: [
          Positioned(
            top: -size.height * 0.02,
            right: -size.width * (size.width < 550 ? 0.58 : 0.13),
            child: Transform.rotate(
              angle: 15.0,
              child: Container(
                height: 360,
                width: 360,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(85),
                    boxShadow: [
                      BoxShadow(
                        color: Color(palette['tertiary']!),
                        blurRadius: 12,
                      )
                    ],
                    gradient: LinearGradient(colors: [
                      Color(palette['secondary']!),
                      Color(palette['tertiary']!),
                    ])),
              ),
            ),
          ),
          Positioned(
            bottom: -size.height * 0.2,
            left: -size.width * (size.width < 550 ? 0.3 : 0.07),
            child: Transform.rotate(
              angle: 15.0,
              child: Container(
                height: 360,
                width: 360,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(palette['tertiary']!),
                        blurRadius: 12,
                      )
                    ],
                    gradient: LinearGradient(colors: [
                      Color(palette['secondary']!),
                      Color(palette['tertiary']!),
                    ])),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(child: LoginContainer()),
          )
        ],
      ),
    );
  }
}

class LoginContainer extends StatefulWidget {
  const LoginContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  String user = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProv = Provider.of<AuthProv>(context);
    return Container(
      constraints: BoxConstraints(maxHeight: size.width * 0.75 + 125),
      padding: const EdgeInsets.all(50),
      width: size.width * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Bienvenido',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(
                  palette['primary']!,
                ),
              ),
            ),
            UserInput(
              function: (data) {
                setState(() {
                  user = data;
                  print(user);
                });
              },
            ),
            PasswordInput(
              function: (data) {
                setState(() {
                  password = data;
                  print(password);
                });
              },
            ),
            Center(
              child: CustomElevatedButton(
                label: 'Iniciar sesión',
                function: () async {
                  if (user != '' && password != '') {
                    if (await authProv.login(user, password)) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Color.fromARGB(255, 43, 163, 39),
                        content: Text(
                          'Has inicado sesión con exito',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ));

                      Navigator.pushReplacementNamed(context, 'home');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Color.fromARGB(255, 206, 49, 38),
                        content: Text(
                          'Error al iniciar sesión',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Color(0XFFFFB818),
                      content: Text(
                        'Rellena todos los paámetros',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ));
                  }
                },
              ),
            )
          ]),
    );
  }
}
