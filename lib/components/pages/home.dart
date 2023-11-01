import 'package:flutter/material.dart';
import 'package:projeto_mobile/Model/author.dart';
import 'package:projeto_mobile/Model/fiction.dart';
import 'package:projeto_mobile/components/fiction_list.dart';
import 'package:projeto_mobile/components/pages/add_fiction_form.dart';
import 'package:projeto_mobile/components/pages/signin_form.dart';
import 'package:projeto_mobile/components/pages/singup_form.dart';
import 'package:projeto_mobile/repositories/author_repository.dart';
import 'package:projeto_mobile/repositories/fiction_repository.dart';
import 'package:projeto_mobile/services/auth_service.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late FictionRepository fictions;
  final List<Author> authors = AuthorRepository.authors;

  _showSignUpForm() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpForm()));
  }

  _showSignInForm() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SignInForm()));
  }

  _showAddFictionForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddFictionForm()),
    );
  }

  @override
  Widget build(BuildContext context) {
    fictions = Provider.of<FictionRepository>(context);
    AuthService auth = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Fictions List"),
        actions: (auth.user != null)
            ? [
                TextButton(
                  onPressed: auth.logoff,
                  child: Text(
                    "Sign off",
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                ),
              ]
            : [
                TextButton(
                  onPressed: _showSignInForm,
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                ),
                TextButton(
                  onPressed: _showSignUpForm,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                ),
              ],
      ),
      body: FictionList(fictions: fictions.fictions),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddFictionForm,
        child: Icon(Icons.add),
      ),
    );
  }
}
