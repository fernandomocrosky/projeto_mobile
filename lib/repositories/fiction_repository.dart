import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:projeto_mobile/Model/chapter.dart';
import 'package:projeto_mobile/Model/fiction.dart';
import 'package:projeto_mobile/repositories/author_repository.dart';

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

  List<Fiction> get fictions => _fictions;

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
