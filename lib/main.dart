import 'package:flutter/material.dart';
import 'package:projeto_mobile/components/my_app.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:projeto_mobile/repositories/chapter_repository.dart';
import 'package:projeto_mobile/repositories/fiction_repository.dart';
import 'package:provider/provider.dart';
import "firebase_options.dart";

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => FictionRepository()),
      ChangeNotifierProvider(create: (context) => ChapterRepository())
    ],
    child: MyApp(),
  ));
}
