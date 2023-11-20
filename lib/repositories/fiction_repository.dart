import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projeto_mobile/Model/chapter.dart';
import 'package:projeto_mobile/Model/fiction.dart';
import 'package:projeto_mobile/repositories/author_repository.dart';
import 'package:http/http.dart' as http;

class FictionRepository extends ChangeNotifier {
  static final List<Fiction> _fictions = [];

  List<Fiction> get fictions => _fictions;

  FictionRepository() {
    _getFictions();
  }

  _getFictions() async {
    final response = await http.get(Uri.parse("http://10.0.2.2:3000/fictions"));
    final List<Fiction> fictions = [];

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> fictions = json;

      print(fictions);

      fictions.forEach((fiction) {
        _fictions.add(Fiction(
          fiction["_id"],
          fiction["title"],
          fiction["description"],
          fiction["grade"],
          fiction["image"],
          fiction["author"],
          [],
        ));
      });
    }

    notifyListeners();
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
