import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pisale/models/theme_model.dart';

class ThemesPage extends StatelessWidget {
  const ThemesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temas'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('themes')
              .orderBy('title')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            final data = snapshot.data!.docs;

            return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: data.length,
                itemBuilder: (context, i) {
                  final currentData = data[i];
                  final actualTheme =
                      ThemeModel.fromJson(jsonEncode(currentData.data()));
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, 'tests',
                          arguments: actualTheme.tests);
                    },
                    leading: Icon(Icons.book),
                    title: Text(
                      actualTheme.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(actualTheme.subtitle),
                    trailing: Icon(Icons.keyboard_arrow_right_rounded),
                  );
                });
          }),
    );
  }
}
