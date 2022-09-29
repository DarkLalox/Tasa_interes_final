import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tesis_1/app/inject_dependencies.dart';
import 'app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await injectDependencies();
  runApp(
    const MyApp(),
  );
}
