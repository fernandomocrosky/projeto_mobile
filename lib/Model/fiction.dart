import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:projeto_mobile/Model/author.dart';
import 'package:projeto_mobile/Model/chapter.dart';

class Fiction extends ChangeNotifier {
  String id;
  String title;
  String description;
  String image;
  int grade;
  String author;
  List<Chapter> chapters;

  Fiction(this.id, this.title, this.description, this.grade, this.image,
      this.author, this.chapters);
}
