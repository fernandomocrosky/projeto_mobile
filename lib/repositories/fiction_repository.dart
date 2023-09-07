import 'package:projeto_mobile/Model/fiction.dart';
import 'package:projeto_mobile/repositories/author_repository.dart';

class FictionRepository {
  static List<Fiction> fictions = [
    Fiction(
      "title",
      "This is a fiction about...",
      5.0,
      "assets/images/default.jpg",
      AuthorRepository.authors[0],
    ),
    Fiction(
      "title #2",
      "This is a fiction about #2...",
      9.1,
      "assets/images/default.jpg",
      AuthorRepository.authors[1],
    ),
  ];
}
