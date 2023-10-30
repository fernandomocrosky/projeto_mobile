import 'package:flutter/material.dart';
import 'package:projeto_mobile/Model/chapter.dart';
import 'package:projeto_mobile/Model/fiction.dart';
import 'package:projeto_mobile/components/pages/chapter_form.dart';
import 'package:projeto_mobile/repositories/fiction_repository.dart';
import 'package:provider/provider.dart';

class FictionPage extends StatefulWidget {
  const FictionPage({super.key, required this.fiction});

  final Fiction fiction;

  @override
  State<FictionPage> createState() => _FictionPageState();
}

class _FictionPageState extends State<FictionPage> {
  _showChapterForm() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChapterForm(
          fiction: widget.fiction,
          id: widget.fiction.chapters.length,
        ),
      ),
    );
  }

  addChapter(final int id, final String title, final String text) {
    setState(() {
      widget.fiction.chapters.add(Chapter(id, title, text));
    });
  }

  @override
  Widget build(BuildContext context) {
    final FictionRepository fictionList =
        Provider.of<FictionRepository>(context);

    Fiction fiction =
        fictionList.fictions.firstWhere((fic) => fic == widget.fiction);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(fiction.title)),
      ),
      body: (widget.fiction.chapters.isNotEmpty)
          ? ListView.separated(
              itemBuilder: (_, index) => ListTile(
                  title: TextButton(
                child: Text(
                  fiction.chapters[index].title,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal),
                ),
                onPressed: () {},
              )),
              separatorBuilder: (_, index) => Divider(),
              itemCount: fiction.chapters.length,
            )
          : Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("No chapters found")],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showChapterForm,
        child: Icon(Icons.add),
      ),
    );
  }
}
