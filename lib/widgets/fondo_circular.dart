import 'package:flutter/material.dart';

class FondoCircular extends StatelessWidget {
  const FondoCircular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned(
          right: -size.width * 1.1,
          top: -size.width * 0.05,
          child: Container(
            width: size.height * 0.8,
            height: size.height * 0.8,
            decoration: BoxDecoration(
              color: Color.fromRGBO(239, 239, 239, 1.0),
              borderRadius: BorderRadius.circular(2000),
            ),
          ),
        ),
      ],
    );
  }
}
