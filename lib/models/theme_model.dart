// To parse this JSON data, do
//
//     final theme = themeFromMap(jsonString);

import 'dart:convert';

class ThemeModel {
  ThemeModel({
    required this.subtitle,
    required this.tests,
    required this.title,
  });

  String subtitle;
  List<String> tests;
  String title;

  factory ThemeModel.fromJson(String str) =>
      ThemeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ThemeModel.fromMap(Map<String, dynamic> json) => ThemeModel(
        subtitle: json["subtitle"],
        tests: List<String>.from(json["tests"].map((x) => x)),
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "subtitle": subtitle,
        "tests": List<dynamic>.from(tests.map((x) => x)),
        "title": title,
      };
}
