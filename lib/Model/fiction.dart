import 'package:projeto_mobile/Model/author.dart';

class Fiction {
  String name;
  String description;
  String image;
  double grade;
  Author author;

  Fiction(this.name, this.description, this.grade, this.image, this.author);
}
