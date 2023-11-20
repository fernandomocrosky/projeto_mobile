import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projeto_mobile/Model/chapter.dart';
import 'package:projeto_mobile/Model/fiction.dart';
import 'package:projeto_mobile/repositories/author_repository.dart';
import 'package:http/http.dart' as http;

class FictionRepository extends ChangeNotifier {
  static final List<Fiction> _fictions = [
    Fiction("title", "This is a fiction about...", 5.0,
        "assets/images/default.jpg", AuthorRepository.authors[0], [
      Chapter(1, "Chapter 1", "Once upon a time"),
      Chapter(2, "Chapter 2", "Twice upon a time")
    ]),
    Fiction(
      "title #2",
      "This is a fiction about #2...",
      9.1,
      "assets/images/default.jpg",
      AuthorRepository.authors[1],
      [],
    ),
  ];

  List<Fiction> get fictions => getFictions() as List<Fiction>;

  getFictions() async {
    final response = await http.get(Uri.parse("localhost:3000/fictions"));
    final List<Fiction> fictions = [];

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      body.map((item) {
        fictions.add(Fiction(body["title"], body["description"], body["grade"],
            body["image"], body["author"], body["chapters"]));
      });
    }

    return fictions;
  }

  addChapter(Chapter chapter, Fiction fiction) {
    _fictions.forEach((f) {
      if (f == fiction) {
        fiction.chapters.add(chapter);
        return;
      }
    });
    notifyListeners();
  }

  saveAll(List<Fiction> fictions) {
    fictions.forEach((fiction) {
      if (!_fictions.contains(fiction)) _fictions.add(fiction);
    });
    notifyListeners();
  }

  remove(Fiction fiction) {
    _fictions.remove(fiction);
    notifyListeners();
  }
}
