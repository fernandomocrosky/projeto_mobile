import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:intl/intl.dart";
import 'package:projeto_mobile/Model/author.dart';
import 'package:projeto_mobile/repositories/author_repository.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:collection/collection.dart";
import 'package:projeto_mobile/services/auth_service.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _form = GlobalKey<FormState>();

  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _birth = TextEditingController();
  final _password = TextEditingController();

  _singUp(auth) async {
    if (_form.currentState!.validate()) {
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _email.text, password: _password.text);
        if (credential.user != null) {
          AuthorRepository.authors.add(Author(_firstName.text, _lastName.text,
              _email.text, _password.text, _birth.text));
          auth.login(_email.text, _password.text);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "weak-password") {
          print("the password is too weak");
        } else if (e.code == "email-already-in-use") {
          print("The account already exists for that email");
        }
      } catch (e) {
        print(e);
      }
      Navigator.pop(context);
    }
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((datePicked) {
      if (datePicked == null) {
        return;
      }
      _birth.text = DateFormat.yMd().format(datePicked);
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Sign Up")),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: SingleChildScrollView(
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
                    } else if (value.length < 3) {
                      return "First name must be 3 or more characters long";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _lastName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Last Name",
                    prefixIcon: Icon(Icons.person),
                    suffix: Text("Your last name"),
                  ),
                  keyboardType: TextInputType.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+")),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Last name cannot be empty";
                    } else if (value.length < 3) {
                      return "Last name must be 3 or more characters long";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    prefixIcon: Icon(Icons.alternate_email),
                    suffix: Text("Your email"),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    final Author? author = AuthorRepository.authors
                        .firstWhereOrNull((element) => element.email == value);
                    if (value!.isEmpty) {
                      return "Email cannot be empty";
                    } else if (author != null) {
                      return "Email already in use";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    prefixIcon: Icon(Icons.key),
                    suffix: Text("Your password"),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password cannot be empty";
                    } else if (value.length < 6) {
                      return "Password must have at least 6 characters";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 80,
                  width: 200,
                  child: TextFormField(
                    controller: _birth,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Birth Date",
                      suffix: IconButton(
                        icon: Icon(Icons.calendar_month),
                        onPressed: _showDatePicker,
                      ),
                    ),
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Birth cannot be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () => _singUp(auth),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ))
              ]),
            ),
          ),
        ));
  }
}
