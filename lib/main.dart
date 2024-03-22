import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:primaprova/authentication/login.dart';
import 'package:primaprova/firebase_options.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( const Mascheroni());
}

class Mascheroni extends StatelessWidget {
  const Mascheroni({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mascheroni',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}
