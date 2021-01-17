import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/todo_item.dart';
import 'package:flutter_application_1/screens/add_edit_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Todos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TodoItem> _items;

   void openAddEdit() async {
          final TodoItem todoItem = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEditScreen(),
            ),
          ); 

          if (todoItem != null) {
            _items.add(todoItem);
            setState(() {});
          }
  }

  @override
  void initState() {
    super.initState();
    _items = List<TodoItem>.empty(growable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_items[index].title),
            subtitle: Text(_items[index].details),
            leading: Checkbox(
              onChanged: (bool value) {
                 TodoItem _changedItem = _items[index].copy(isCompleted: value);
                 _items.removeAt(index);
                 _items.insert(index, _changedItem);
                 setState(() {});
                 }, 
                 value: _items[index].isCompleted?? false,
                 ),
          );
        },
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddEdit,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }
}
