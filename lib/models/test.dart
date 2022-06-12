// To parse this JSON data, do
//
//     final test = testFromMap(jsonString);

import 'dart:convert';

class Test {
  Test({
    required this.title,
    required this.questions,
  });

  String title;
  List<String> questions;

  factory Test.fromJson(String str) => Test.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Test.fromMap(Map<String, dynamic> json) => Test(
        title: json["title"],
        questions: List<String>.from(json["questions"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "questions": List<dynamic>.from(questions.map((x) => x)),
      };
}
