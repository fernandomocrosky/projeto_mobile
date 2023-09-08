import 'package:flutter/material.dart';
import 'package:projeto_mobile/repositories/author_repository.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _form = GlobalKey<FormState>();
  bool checkPassword = true;
  final _email = TextEditingController();
  final _password = TextEditingController();

  _signIn() {
    if (_form.currentState!.validate()) {
      final user = AuthorRepository.authors
          .firstWhere((author) => author.email == _email.text);
      if (user != null) {
        if (_password.text == user.password) {
          print("logado");
          setState(() {
            checkPassword = true;
          });
          Navigator.pop(context);
        } else {
          setState(() {
            checkPassword = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Sign In")),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                  prefixIcon: Icon(Icons.person),
                  suffix: Text("Your Email"),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cannot be empty";
                  } else if (!checkPassword) {
                    setState(() {
                      checkPassword = true;
                    });
                    return "Email or password invalid";
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                controller: _password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                  prefixIcon: Icon(Icons.key),
                  suffix: Text("Your Password"),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cannot be empty";
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _signIn,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign in",
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
