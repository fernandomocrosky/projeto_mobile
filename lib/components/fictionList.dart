import 'package:flutter/material.dart';
import 'package:projeto_mobile/Model/fiction.dart';
import 'package:projeto_mobile/components/fictionCard.dart';
import 'package:projeto_mobile/repositories/fiction_repository.dart';

class FictionList extends StatelessWidget {
  FictionList({super.key});

  final List<Fiction> fictions = FictionRepository.fictions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: FictionRepository.fictions.length,
        itemBuilder: (_, index) {
          return FictionCard(fiction: fictions[index]);
        });
  }
}
