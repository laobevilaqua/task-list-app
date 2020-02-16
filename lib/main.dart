import 'package:flutter/material.dart';

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
    items.add(Item(title: 'Criar Navbar', done: true));
    items.add(Item(title: 'Criar uma lista de checkbox locada', done: true));
    items.add(Item(title: 'Integrar mudanças', done: false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        // it is not necessary to type the parameters. Ex itemBuilder: (ctxt, index)
        itemBuilder: (BuildContext ctxt, int index) {
          // final equivalent const in javascript
          final item = widget.items[index];

          return CheckboxListTile(
            title: Text(item.title),
            key: Key(item.title),
            value: item.done,
            activeColor: Colors.orange,
            onChanged: (value) {
              // works only on statefulwidget.
              // for update screen
              setState(() {
                item.done = value;
              });
            },
          );
        },
      ),
    );
  }
}
