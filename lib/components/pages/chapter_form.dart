import 'package:flutter/material.dart';
import 'package:projeto_mobile/Model/chapter.dart';
import 'package:projeto_mobile/Model/fiction.dart';
import 'package:projeto_mobile/repositories/fiction_repository.dart';
import 'package:provider/provider.dart';

class ChapterForm extends StatefulWidget {
  const ChapterForm({super.key, required this.fiction, required this.id});

  final Fiction fiction;
  final int id;

  @override
  State<ChapterForm> createState() => _ChapterFormState();
}

class _ChapterFormState extends State<ChapterForm> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _text = TextEditingController();
  late FictionRepository fictions;

  _submitForm() {
    if (_form.currentState!.validate()) {
      Navigator.of(context).pop();
      fictions.addChapter(
          Chapter(widget.id, _title.text, _text.text), widget.fiction);
    }
  }

  @override
  Widget build(BuildContext context) {
    fictions = Provider.of<FictionRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Add Chapter")),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(top: 20),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                controller: _title,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "title",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Title cannot be empty";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "text",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Title cannot be empty";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _submitForm,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add Chapter",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
