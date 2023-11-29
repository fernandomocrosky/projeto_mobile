import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projeto_mobile/Model/chapter.dart';
import 'package:projeto_mobile/Model/fiction.dart';
import 'package:projeto_mobile/repositories/author_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class FictionRepository extends ChangeNotifier {
  static final List<Fiction> _fictions = [];

  List<Fiction> get fictions => _fictions;

  FictionRepository() {
    _getFictions();
  }

  _getFictions() async {
    final response = await http
        .get(Uri.parse("https://projeto-mobile-d-utf.onrender.com/fictions"));
    final List<Fiction> fictions = [];

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> fictions = json;

      print(fictions);
      final int length = _fictions.length;
      for (int i = 0; i < length; i++) {
        _fictions.removeAt(0);
      }
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

      for (int i = 0; i < fictions.length; i++) {
        for (int j = 0; j < fictions[i]["chapters"].length; j++) {
          _fictions[i].chapters.add(Chapter(
              fictions[i]["chapters"][j]["id"],
              fictions[i]["chapters"][j]["title"],
              fictions[i]["chapters"][j]["text"]));
        }
      }
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

  saveAll(File image, String title, String description) async {
    var request = http.MultipartRequest("POST",
        Uri.parse("https://projeto-mobile-d-utf.onrender.com/fictions"));
    Map<String, String> headers = {"Content-Type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        "file",
        image.readAsBytes().asStream(),
        image.lengthSync(),
        filename: "Image1",
        contentType: MediaType("image", "jpeg"),
      ),
    );
    request.headers.addAll(headers);
    request.fields.addAll({
      "title": title,
      "description": description,
      "author": "Author 0",
    });

    var res = await request.send();
    if (res.statusCode == 200) {
      _getFictions();
    }
  }

  remove(Fiction fiction) {
    _fictions.remove(fiction);
    notifyListeners();
  }
}
