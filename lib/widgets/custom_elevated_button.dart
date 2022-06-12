import 'package:flutter/material.dart';
import 'package:pisale/propeties.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key? key, required this.function, required this.label})
      : super(key: key);

  final Function function;
  final String label;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      ),
      onPressed: () => function(),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(palette['tertiary']!),
              Color(
                palette['secondary']!,
              )
            ],
          ),
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: 200, minHeight: 50),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
