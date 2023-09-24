import 'package:flutter/material.dart';
import 'package:projeto_mobile/Model/fiction.dart';
import 'package:projeto_mobile/components/pages/fiction_page.dart';

class FictionCard extends StatelessWidget {
  const FictionCard({super.key, required this.fiction});
  final Fiction fiction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
      child: Column(
        children: [
          Text(
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            fiction.title,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: IconButton(
              icon: Image.asset(fiction.image),
              iconSize: 200,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => FictionPage(fiction: fiction)));
              },
            ),
          ),
          Text(fiction.description),
          Text("${fiction.author.firstName} ${fiction.author.lastName}"),
          Text(fiction.grade.toString()),
        ],
      ),
    );
  }
}
