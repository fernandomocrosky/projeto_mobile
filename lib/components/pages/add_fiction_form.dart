import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_mobile/Model/fiction.dart';
import 'package:projeto_mobile/repositories/author_repository.dart';
import 'package:projeto_mobile/repositories/fiction_repository.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import "package:http_parser/http_parser.dart";

class AddFictionForm extends StatefulWidget {
  const AddFictionForm({super.key});

  @override
  State<AddFictionForm> createState() => _AddFictionFormState();
}

class _AddFictionFormState extends State<AddFictionForm> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  late FictionRepository fictions;
  File? image;

  submitForm() {
    if (_form.currentState!.validate()) {
      fictions.saveAll(image!, _title.text, _description.text);
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  selecionarImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);

      if (file != null) setState(() => image = File(file.path));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    fictions = Provider.of<FictionRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Add New Fiction"),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                SizedBox(height: 20),
                TextFormField(
                  controller: _title,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Title",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Title cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _description,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Description",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Description cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.attach_file),
                  title: Text("Image File"),
                  onTap: selecionarImage,
                  trailing:
                      image != null ? Image.file(File(image!.path)) : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: submitForm,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add Fiction",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
