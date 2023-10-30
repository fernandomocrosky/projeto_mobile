import 'package:flutter/material.dart';
import 'package:projeto_mobile/Model/fiction.dart';
import 'package:projeto_mobile/components/fiction_card.dart';
import 'package:projeto_mobile/repositories/fiction_repository.dart';

class FictionList extends StatelessWidget {
  FictionList({super.key, required this.fictions});

  final List<Fiction> fictions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: fictions.length,
        itemBuilder: (_, index) {
          return FictionCard(fiction: fictions[index]);
        });
  }
}
