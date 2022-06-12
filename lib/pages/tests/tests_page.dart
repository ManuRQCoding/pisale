import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pisale/models/test.dart';
import 'package:pisale/providers/test_provider.dart';
import 'package:provider/provider.dart';

class TestsPage extends StatelessWidget {
  const TestsPage({Key? key}) : super(key: key);

  // Future<List<QuerySnapshot<Object?>>> getTestsByIds(
  //     List<String> testsIds) async {
  //   final List<QuerySnapshot> list = [];
  //   testsIds.forEach((testId) async {
  //     final item = await FirebaseFirestore.instance
  //         .collection('tests')
  //         .doc(testId)
  //         .get();

  //     print(item.get('title'));
  //   });

  //   return list;
  // }

  @override
  Widget build(BuildContext context) {
    final testsIds =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final testProv = Provider.of<TestProvider>(context);
    final palette = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tests'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('tests')
              .where(FieldPath.documentId,
                  whereIn: testsIds.map((e) => e.toString()).toList())
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            final data = snapshot.data!.docs;
            data.sort((a, b) => a
                .get('title')
                .toString()
                .toLowerCase()
                .compareTo(b.get('title').toString().toLowerCase()));

            return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: data.length,
                itemBuilder: (context, i) {
                  final currentData = data[i];
                  final actualTest =
                      Test.fromJson(jsonEncode(currentData.data()));

                  return ListTile(
                    onTap: () async {
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
                                            backgroundColor:
                                                MaterialStateProperty.all(
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
                                            backgroundColor:
                                                MaterialStateProperty.all(
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
                        Navigator.pushNamed(context, 'questions',
                            arguments: actualTest.questions);
                      }
                    },
                    leading: Icon(Icons.question_mark_rounded),
                    title: Text(
                      actualTest.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right_rounded),
                  );
                });
          }),
    );
  }
}
