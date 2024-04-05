
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:primaprova/authentication/login.dart';
import 'package:primaprova/firebase_options.dart';
import 'package:primaprova/notes/homepage.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Prima applicazione'),
          backgroundColor: Colors.red,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
              ),
        builder: (context, snapshot) {
          return Column(
          children: [
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Inserisci Mail',
              ),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Inserisci password'
              ),
            ),
            TextButton(
              onPressed: () async { 
                final email = _email.text;
                final password = _password.text;
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email, 
                  password: password);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context)=>  HomePage())
                  );
               },
               child: const Text('Registrati!'),
            ),
            TextButton(onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: 
                (context) => const Login())
              );
            }, child: const Text("Sei già registrato? Fai il login!"))
          ],
        );
        },
      ),
    );
  }
}
