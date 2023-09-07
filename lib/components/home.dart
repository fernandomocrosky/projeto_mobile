import 'package:flutter/material.dart';
import 'package:projeto_mobile/components/fictionCard.dart';
import 'package:projeto_mobile/components/fictionList.dart';
import 'package:projeto_mobile/components/pages/singup_form.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _showSignUpForm() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SingnUpForm()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fictions List"),
        actions: [
          TextButton(
            onPressed: () {},
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
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
