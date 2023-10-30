import 'package:flutter/material.dart';
import 'package:projeto_mobile/Model/chapter.dart';

class ChapterRepository extends ChangeNotifier {
  static final List<Chapter> _chapters = [
    Chapter(1, "Chapter 1", "Once upon a time"),
    Chapter(2, "Chapter 2", "Twice upon a time"),
  ];

  List<Chapter> get chapters => _chapters;

  saveAll(List<Chapter> chapters) {
    chapters.forEach((c) {
      if (!_chapters.contains(c)) {
        _chapters.add(c);
      }
    });
    notifyListeners();
  }
}
