import 'package:flutter/material.dart';
import 'package:projeto_mobile/components/fictionList.dart';
import 'package:projeto_mobile/components/pages/new_fiction_form.dart';
import 'package:projeto_mobile/components/pages/signin_form.dart';
import 'package:projeto_mobile/components/pages/singup_form.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _showSignUpForm() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpForm()));
  }

  _showSignInForm() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SignInForm()));
  }

  _addFiction() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => NewFictionForm()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fictions List"),
        actions: [
          TextButton(
            onPressed: _showSignInForm,
            child: Text(
              "Sign in",
              style: TextStyle(
                  fontSize: 15, color: Theme.of(context).secondaryHeaderColor),
            ),
          ),
          TextButton(
            onPressed: _showSignUpForm,
            child: Text(
              "Sign Up",
              style: TextStyle(
                  fontSize: 15, color: Theme.of(context).secondaryHeaderColor),
            ),
          ),
        ],
      ),
      body: FictionList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFiction,
        child: Icon(Icons.add),
      ),
    );
  }
}
