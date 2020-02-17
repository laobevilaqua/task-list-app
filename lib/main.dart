import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/item.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage() {
    items = [];
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController newTaskCtrl = TextEditingController();

  void add() {
    setState(() {
      if (newTaskCtrl.text.isEmpty) return;
      widget.items.add(Item(title: newTaskCtrl.text, done: false));
      
      newTaskCtrl.clear();
      
      save();
    });
  }
  
  void remove(int index) {
    setState(() {
      widget.items.removeAt(index);
      save();
    });
  }
  
  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();
      setState(() {
        widget.items = result;
      });
    }
  }

  _HomePageState() {
    load();
  }
 
 save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.items));
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTaskCtrl,
          // helps the user by giving keyboard shortcuts like @, or words
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            labelText: 'Nova Tarefa',
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        // it is not necessary to type the parameters. Ex itemBuilder: (ctxt, index)
        itemBuilder: (BuildContext ctxt, int index) {
          // final equivalent const in javascript
          final item = widget.items[index];

          return Dismissible(
            key: Key(item.title),
            background: Container(
              color: Colors.red.withOpacity(0.4)
            ),
            onDismissed: (direction) {
              if(direction == DismissDirection.endToStart) {
                remove(index);
              }
            },
            child: CheckboxListTile(
              title: Text(item.title),
              value: item.done,
              activeColor: Colors.orange,
              onChanged: (value) {
                // works only on statefulwidget.
                // for update screen
                setState(() {
                  item.done = value;
                  save();
                });
              },
            )
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
        ),
    );
  }
}
