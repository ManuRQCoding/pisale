import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({Key? key, required this.function}) : super(key: key);

  final Function function;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool visibility = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      autocorrect: false,
      obscureText: !visibility,
      initialValue: '',
      onChanged: (data) {
        widget.function(data);
      },
      cursorColor: Colors.grey,
      style: const TextStyle(
        fontSize: 20,
      ),
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                visibility = !visibility;
              });
            },
            icon: Icon(
              visibility ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            )),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        labelText: 'Contraseña',
        labelStyle: TextStyle(color: Colors.grey, fontSize: 25),
      ),
    );
  }
}
