import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewFictionForm extends StatefulWidget {
  const NewFictionForm({super.key});

  @override
  State<NewFictionForm> createState() => _NewFictionFormState();
}

class _NewFictionFormState extends State<NewFictionForm> {

  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Center(child: Text("Add new Fiction")),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Form(
          key: _form,
          child: Column(children: [
            TextFormField(
              controller: _title,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Fiction Title",
              ),
              keyboardType: TextInputType.name,
              validator: (value) {
                if(value!.isEmpty) {
                  return "Title cannot be empty";
                }
              }
            ),
          ],),
        ),
      ),
    );
  }
}