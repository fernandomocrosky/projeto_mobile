import 'package:flutter/material.dart';
import 'package:projeto_mobile/Model/fiction.dart';

class FictionPage extends StatelessWidget {
  const FictionPage({super.key, required this.fiction});

  final Fiction fiction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(fiction.title)),
      ),
    );
  }
}
