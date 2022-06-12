import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AuthProv extends ChangeNotifier {
  QueryDocumentSnapshot<Map<String, dynamic>>? userLogged;

  Future<bool> login(String user, String password) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: user)
        .where('password', isEqualTo: password)
        .get();
    if (result.size > 0) {
      userLogged = result.docs.first;
    }

    return result.size > 0;
  }
}
