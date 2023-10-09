import 'package:flutter/material.dart';

class ChapterForm extends StatefulWidget {
  const ChapterForm({super.key, required this.addChapter, required this.id});

  final Function addChapter;
  final int id;

  @override
  State<ChapterForm> createState() => _ChapterFormState();
}

class _ChapterFormState extends State<ChapterForm> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _text = TextEditingController();

  _submitForm() {
    if (_form.currentState!.validate()) {
      widget.addChapter(
        widget.id,
        "Chapter ${widget.id}",
        _title.text,
        _text.text,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
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
