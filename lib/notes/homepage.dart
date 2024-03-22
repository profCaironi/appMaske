import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<String> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _showAddMessage() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Inserisci una nota"),
          content: TextField(
            controller: _controller,
          ),
          actions:[
            TextButton(onPressed: 
            () {
              Navigator.pop(context);
            }, 
            child: Text("Annulla")
            ),
            TextButton(
              onPressed: () {
                if(_controller.text.isNotEmpty){
                  setState(
                    () {
                    _messages.add(_controller.text);
                    _controller.clear();
                  }
                  );
                  Navigator.pop(context);
                }
              },
               child: Text("Ok")
               )
          ]
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: Text("Benvenuto nella homepage"),
    );
  }
}