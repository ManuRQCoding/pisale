import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:pisale/models/question.dart';

class TestProvider extends ChangeNotifier {
  bool studyMode = false;

  final List<Question?> questionsAnswered = [];

  void reset() {
    questionsAnswered.clear();
  }

  void start(int lenght) {
    for (var i = 0; i < lenght; i++) {
      questionsAnswered.add(null);
    }
    print(questionsAnswered);
  }

  void changeStudyMode(bool value) {
    studyMode = value;
    notifyListeners();
  }

  void add(Question question, int pos) {
    questionsAnswered[pos] = question;
    print(questionsAnswered);
    notifyListeners();
  }

  int getAciertos() {
    return questionsAnswered
        .where((q) => q != null ? q.selected!.correct : false)
        .length;
  }

  int getFallos() {
    return questionsAnswered
        .where((q) => q != null ? !q.selected!.correct : false)
        .length;
  }

  void updateUserResults(
      QueryDocumentSnapshot<Map<String, dynamic>> userLogged) {
    int errors = getFallos();
    final map = {
      'errors': userLogged.get('errors') + errors,
      'exam_count': userLogged.get('exam_count') + 1,
      'exam_fails': userLogged.get('exam_fails') + (getFallos() > 3 ? 1 : 0),
      'exam_passed': userLogged.get('exam_passed') + (getFallos() <= 3 ? 1 : 0),
      'rights': userLogged.get('rights') + getAciertos(),
    };
    FirebaseFirestore.instance
        .collection('users')
        .doc(userLogged.id)
        .update(map);
  }
}
