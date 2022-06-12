import 'dart:convert';

class Answer {
  Answer({
    required this.content,
    required this.correct,
  });

  String content;
  bool correct;

  factory Answer.fromJson(String str) => Answer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Answer.fromMap(Map<String, dynamic> json) => Answer(
        content: json["content"],
        correct: json["correct"],
      );

  Map<String, dynamic> toMap() => {
        "content": content,
        "correct": correct,
      };
}
