
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:primaprova/authentication/registration.dart';
import 'package:primaprova/firebase_options.dart';
import 'package:primaprova/notes/homepage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

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
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context)=> const HomePage())
                  );
                } on FirebaseAuthException catch (e) {
                  if(e.code == "invalid-email"){
                    print("Email non valida");
                  }
                  else if(e.code == "invalid-credential"){
                    print("Credenziali non valide");
                  }
                }
               },
               child: const Text('Login!'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Registration()
                  )
                );
            },
             child: const Text("Non sei ancora registrato? Registrati!"))
          ],
        );
        },
      ),
    );
  }
}
