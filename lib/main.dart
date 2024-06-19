import 'package:app/api/firebase_api.dart';
import 'package:app/firebase_options.dart';
import 'package:app/firebase_services.dart';

import 'package:app/scaffold_login.dart';
import 'package:app/scaffold_padres.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffoldlogin(),
      routes: {
        '/scaffoldPadres': (context) => const ScaffoldPadres(),
      },
    );
  }
}
