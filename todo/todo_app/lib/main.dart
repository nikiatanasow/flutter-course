import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/screens/add_edit_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todos',
      home: MyHomePage(title: 'Flutter Todos'),
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
  List<TodoItem> _todoItems;

  @override
  void initState() {
    super.initState();
    _todoItems = List<TodoItem>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _todoItems.length,
        itemBuilder: (context, index) {
          final TodoItem todoItem = _todoItems[index];
          return ListTile(
            title: Text(todoItem.title),
            subtitle: Text(todoItem.details),
            leading: Checkbox(
              onChanged: (value) {
                final changedTodoItem = todoItem.copy(isCompleted: value);
                _todoItems.removeAt(index);
                _todoItems.insert(index, changedTodoItem);
                setState(() {});
              },
              value: todoItem.isCompleted ?? false,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final TodoItem todoItem = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEditScreen(),
            ),
          );

          if (todoItem != null) {
            _todoItems.add(todoItem);
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
