import 'package:flutter/material.dart';

import 'models/item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
var items = new List<Item>();

HomePage(){
  items = [];
  items.add(Item(title:"Ir ao Poupa Tempo", done:true));
  items.add(Item(title:"Comprar Teclado", done:true));
  items.add(Item(title:"Comprar Mouse", done:true));
}

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
    String response = "";
    void setResponse(value){
      setState(() {
        response = value;
      });
  }

  Future<Null> _responseUser(){
    
  }
    
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("ToDo List"),
        ),
        body: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (linha,index){
            final item = widget.items[index];
            return CheckboxListTile(
              title: Text(item.title),
              key: Key(item.title),
              value: item.done,
              onChanged: (value){
                setState(() {
                  item.done = value;
                });
              },
            );
          },
        ),
          floatingActionButton: FloatingActionButton(
      onPressed: () {
  
      },
      tooltip: "Adicionar Nova Tarefa",
      child: Icon(Icons.check),
          
        ),
      );
    }
}


