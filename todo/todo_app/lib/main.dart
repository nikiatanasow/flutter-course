import 'package:flutter/material.dart';
import 'package:todo_app/models/edited_item.dart';
import 'package:todo_app/models/filter_popup_item.dart';
import 'package:todo_app/models/options_popup_item.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/screens/add_edit_screen.dart';
import 'package:todo_app/screens/details_screen.dart';

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
  List<TodoItem> _filteredItems;

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
        actions: [
          PopupMenuButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Icon(Icons.filter_list),
            ),
            onSelected: (type) {
              switch (type) {
                case FilterPopupItem.all:
                  _filteredItems = null;
                  break;
                case FilterPopupItem.active:
                  _filteredItems = _todoItems
                      .where((element) =>
                          element.isCompleted == false ||
                          element.isCompleted == null)
                      .toList();
                  break;
                case FilterPopupItem.completed:
                  _filteredItems = _todoItems
                      .where((element) => element.isCompleted == true)
                      .toList();
                  break;
              }

              setState(() {});
            },
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                PopupMenuItem<FilterPopupItem>(
                  value: FilterPopupItem.all,
                  child: Text('Show all'),
                ),
                PopupMenuItem<FilterPopupItem>(
                  value: FilterPopupItem.active,
                  child: Text('Show active'),
                ),
                PopupMenuItem<FilterPopupItem>(
                  value: FilterPopupItem.completed,
                  child: Text('Show completed'),
                ),
              ];
            },
          ),
          PopupMenuButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Icon(Icons.more_horiz),
            ),
            onSelected: (value) {
              if (value == OptionsPopupItem.markAllActive) {
                _todoItems =
                    _todoItems.map((e) => e.copy(isCompleted: false)).toList();
              } else {
                _todoItems =
                    _todoItems.map((e) => e.copy(isCompleted: true)).toList();
              }
              setState(() {});
            },
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                PopupMenuItem<OptionsPopupItem>(
                  value: OptionsPopupItem.markAllActive,
                  child: Text('Mark all active'),
                ),
                PopupMenuItem<OptionsPopupItem>(
                  value: OptionsPopupItem.markAllCompleted,
                  child: Text('Mark all completed'),
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount:
            _filteredItems != null ? _filteredItems.length : _todoItems.length,
        itemBuilder: (context, index) {
          final TodoItem todoItem = _filteredItems != null
              ? _filteredItems[index]
              : _todoItems[index];
          return Stack(
            children: [
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        item: todoItem,
                      ),
                    ),
                  ) as EditedItem;

                  if (result != null) {
                    switch (result.operation) {
                      case ItemOperation.Delete:
                        _todoItems.remove(result.item);
                        _filteredItems?.remove(result.item);
                        setState(() {});
                        break;
                      case ItemOperation.Edit:
                        final realIndex = _todoItems.indexOf(todoItem);
                        _todoItems.removeAt(realIndex);
                        _todoItems.insert(realIndex, result.item);

                        _filteredItems?.removeAt(index);
                        _filteredItems?.insert(index, result.item);

                        setState(() {});
                        break;
                    }
                  }
                },
                child: Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    final realIndex = _todoItems.indexOf(todoItem);
                    _todoItems.removeAt(realIndex);
                    _filteredItems?.removeAt(index);

                    final snackBar = SnackBar(
                      content: Text(
                        'Item ${todoItem.title} has been deleted!',
                      ),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          _todoItems.insert(index, todoItem);
                          _filteredItems?.insert(index, todoItem);
                          setState(() {});
                        },
                      ),
                    );

                    Scaffold.of(context).showSnackBar(snackBar);
                  },
                  child: ListTile(
                    title: Text(todoItem.title),
                    subtitle: Text(todoItem.details),
                    leading: Checkbox(
                      onChanged: (value) {
                        final changedTodoItem =
                            todoItem.copy(isCompleted: value);
                        _todoItems.removeAt(index);
                        _todoItems.insert(index, changedTodoItem);
                        _filteredItems?.removeAt(index);
                        _filteredItems?.insert(index, changedTodoItem);
                        setState(() {});
                      },
                      value: todoItem.isCompleted ?? false,
                    ),
                  ),
                ),
              ),
            ],
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
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
            ),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.data_usage,
            ),
            label: 'Stats',
          ),
        ],
      ),
    );
  }
}
