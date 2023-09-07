import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingnUpForm extends StatefulWidget {
  const SingnUpForm({super.key});

  @override
  State<SingnUpForm> createState() => _SingnUpFormState();
}

class _SingnUpFormState extends State<SingnUpForm> {
  final _form = GlobalKey<FormState>();

  final _firstName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Sign Up")),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Form(
            key: _form,
            child: Column(children: [
              TextFormField(
                controller: _firstName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "First Name",
                  prefixIcon: Icon(Icons.person),
                  suffix: Text("Your first name"),
                ),
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+")),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "First name cannot be empty";
                  } else if (value.length <= 3) {
                    return "Name must be 3 or more characters long";
                  }
                },
              ),
            ]),
          ),
        ));
  }
}
