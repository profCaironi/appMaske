import 'package:flutter/material.dart';

class Note{
  String text;
  Color color;

  Note({
    required this.text,
    this.color = Colors.grey
  });
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Note> _messages = [];
  final TextEditingController _controller = TextEditingController();

  List<Color> coloriDisponibili = [
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.purple
  ];

  void _showColor(int index) async {
    await showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Scegli un colore!"),
          content: Wrap(
            children: List<Widget>.generate(coloriDisponibili.length, (int colorIndex) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _messages[index].color = coloriDisponibili[colorIndex];
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.all(4),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: coloriDisponibili[colorIndex],
                    shape: BoxShape.circle,
                  ),
                )
              );
            } 
            )
          ),
          actions: <Widget>[
            TextButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text("Annulla"))
          ]
        );
      }
      );
  }

  void _showAddOrEditMessage({String? initialText, int? index}) async {
    if(initialText !=null){
      _controller.text = initialText;
    }
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Inserisci un messaggio'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Scrivi qualcosa qui"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Annulla'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  setState(() {
                    if(index == null){
                      _messages.add(
                        Note(text: _controller.text, color: Colors.grey)
                      );
                    }
                    else{
                      _messages[index].text = _controller.text;
                    }          
                    _controller.clear();
                  });
                  Navigator.pop(context);
                }
              },
            ),
            if(index != null)
            IconButton(onPressed: () => _showColor(index),
             icon: const Icon(Icons.palette))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Lista di Messaggi'),
        actions: [
          IconButton(onPressed: _showAddOrEditMessage, icon: const Icon(Icons.add_alert)),
        ]
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text("Menù"),
              decoration: BoxDecoration(
                color: Colors.amber
              ),
              ),
            ListTile(
              title: Text("Aggiungi nota"),
              onTap: () {
                Navigator.pop(context);
                _showAddOrEditMessage();
              },
            ),
            ListTile(
              title: Text("Impostazioni"),
              onTap: () {
                Navigator.pop(context);
                //TODO crea pagina impostazioni
              },
            ),
            ListTile(
              title: Text("Profilo"),
              onTap: () {
                Navigator.pop(context);
                //TODO crea pagina profilo
              },
            ),
          ],
        )
      ),
      body: ListView.builder(
        itemCount: _messages.length,
        itemBuilder: (context, index){
          return Container(
            color: _messages[index].color,
            child: ListTile(
              title: Text(_messages[index].text),
              onTap: () {
                _showAddOrEditMessage(initialText: _messages[index].text, index: index);
              },
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _messages.removeAt(index);
                  });
                },
                ),
            
            ),
          );
        }
        )
    );
  }
}