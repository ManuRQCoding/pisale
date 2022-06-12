import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pisale/providers/test_provider.dart';
import 'package:provider/provider.dart';

import '../../propeties.dart';

class RandomTests extends StatelessWidget {
  const RandomTests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tests aleatorios'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Número de preguntas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: palette.primary,
              ),
            ),
          ),
          SliderRandomTestWidget(),
        ],
      ),
    );
  }
}

class SliderRandomTestWidget extends StatefulWidget {
  const SliderRandomTestWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SliderRandomTestWidget> createState() => _SliderRandomTestWidgetState();
}

class _SliderRandomTestWidgetState extends State<SliderRandomTestWidget> {
  double _currentSliderValue = 15;

  randomQuestions(BuildContext context) async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> result = [];
    List<QueryDocumentSnapshot<Map<String, dynamic>>> allQuestions =
        (await FirebaseFirestore.instance.collection('questions').get()).docs;
    print('longitud de todas las preguntas');
    print(allQuestions.length);
    num numOfQuestions = _currentSliderValue > allQuestions.length
        ? allQuestions.length
        : _currentSliderValue;
    while (result.length < numOfQuestions) {
      final randomPos = Random().nextInt(allQuestions.length);
      result.add(allQuestions[randomPos]);
      allQuestions.remove(allQuestions[randomPos]);
    }

    Navigator.pushNamed(context, 'questions',
        arguments: result.map((element) => element.id).toList());
  }

  @override
  Widget build(BuildContext context) {
    final testProv = Provider.of<TestProvider>(context);
    final palette = Theme.of(context).colorScheme;
    return Column(
      children: [
        Slider(
          value: _currentSliderValue,
          onChanged: (value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
          divisions: 2,
          label: _currentSliderValue.round().toString(),
          min: 15,
          max: 45,
          activeColor: palette.tertiary,
          thumbColor: palette.secondary,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _currentSliderValue.toStringAsFixed(0),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: palette.primary,
            ),
          ),
        ),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(palette.primary),
            ),
            onPressed: () async {
              final res = await showDialog<bool>(
                  context: context,
                  builder: (context) => Dialog(
                        insetPadding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 200,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Selecciona el modo de examen:',
                                style: TextStyle(
                                    color: palette.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        palette.secondary),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text('Modo estudio')),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        palette.secondary),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text('Modo examen'))
                            ],
                          ),
                        ),
                      ));

              if (res != null) {
                testProv.changeStudyMode(res);
                randomQuestions(context);
              }
            },
            child: Text('Iniciar test aleatorio'))
      ],
    );
  }
}
