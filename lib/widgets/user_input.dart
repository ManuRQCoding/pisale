import 'package:flutter/material.dart';

class UserInput extends StatelessWidget {
  const UserInput({Key? key, required this.function}) : super(key: key);

  final Function function;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      autocorrect: false,
      initialValue: '',
      onChanged: (data) {
        function(data);
      },
      cursorColor: Colors.grey,
      style: const TextStyle(
        fontSize: 20,
      ),
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        labelText: 'Usuario',
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 25),
      ),
    );
  }
}
