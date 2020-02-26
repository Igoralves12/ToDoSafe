import 'dart:ffi';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  // items.add(Item(title:"Ir ao Poupa Tempo", done:true));
  // items.add(Item(title:"Comprar Teclado", done:true));
  // items.add(Item(title:"Comprar Mouse", done:true));
}

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
   var taskControl = TextEditingController();
   _HomePageState(){
     load();
   }
  /* 
    String response = "";
    void setResponse(value){
      setState(() {
        widget.items.add(Item(title: taskControl.text, done:false));
        print("Inclusao de novo item");
      });
      taskControl.clear();
  }

  Future<Null> _responseUser() async{

      await showDialog(context: context,
      child: SimpleDialog(
        title: TextFormField(
          controller: taskControl,
          keyboardType: TextInputType.text,
          ),
      
        )
      );
  }*/
  Future load()async{
    var shared = await SharedPreferences.getInstance();
    var data = shared.getString('data');
    if(data != null){
      print(data);
      Iterable response = jsonDecode(data);
      List<Item> responseList = response.map((x) => Item.fromJson(x)).toList(); 
     
      setState(() {
       widget.items = responseList;
      });
    }
  }

  save()async{
    var shared = await SharedPreferences.getInstance();
    await shared.setString('data', jsonEncode(widget.items));
    print("salvo");
  }
  void add(){
    setState(() {
      if(taskControl.text.isNotEmpty){
        widget.items.add(Item(title: taskControl.text,done:false));
        taskControl.clear();
        save();
      }else{
        return;
      }
    });
  }

  void remove(int index){
    setState(() {
      widget.items.removeAt(index);
      save();
    });
  }
    
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: TextFormField(
            controller: taskControl,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,

            ),
            decoration: InputDecoration(
              labelText: "ToDo",
              labelStyle: TextStyle(color: Colors.white)
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (linha,index){
            final item = widget.items[index];
            return Dismissible(
              child: CheckboxListTile(
              title: Text(item.title),
              
              value: item.done,
              onChanged: (value){
                setState(() {
                  item.done = value;
                  save();
                  });
                },
              ),
              key: Key(item.title),
              onDismissed: (direction){
                print(direction);
                remove(index);
              },
            );
          },
        ),
          floatingActionButton: FloatingActionButton(
      onPressed: add,
      tooltip: "Adicionar Nova Tarefa",
      child: Icon(Icons.check),
        ),
      );
    }
}


