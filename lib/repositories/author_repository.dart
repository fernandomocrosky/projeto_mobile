import 'package:projeto_mobile/Model/author.dart';
import "package:intl/intl.dart";

class AuthorRepository {
  static List<Author> authors = [
    Author(
      "Author",
      "first",
      "email@email.com",
      DateFormat.yMd().format(DateTime.now()),
    ),
    Author(
      "Author",
      "second",
      "email@email.com",
      DateFormat.yMd().format(DateTime.now()),
    ),
    Author(
      "Author",
      "third",
      "email@email.com",
      DateFormat.yMd().format(DateTime.now()),
    ),
  ];
}
