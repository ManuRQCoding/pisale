// To parse this JSON data, do
//
//     final question = questionFromMap(jsonString);

import 'dart:convert';

import 'package:pisale/models/answer.dart';

class Question {
  Question({
    required this.answers,
    required this.content,
    required this.help,
    required this.image,
  });

  List<Answer> answers;
  String content;
  String help;
  String? image;
  Answer? selected;

  factory Question.fromJson(String str) => Question.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Question.fromMap(Map<String, dynamic> json) => Question(
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromMap(x))),
        content: json["content"],
        help: json["help"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "answers": List<dynamic>.from(answers.map((x) => x.toMap())),
        "content": content,
        "help": help,
        "image": image,
      };
}
