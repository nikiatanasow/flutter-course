import 'package:flutter/material.dart';
import 'package:todo_app/models/edited_item.dart';
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
  GlobalKey _filterBtnKey = GlobalKey();

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
          IconButton(
            key: _filterBtnKey,
            icon: Icon(Icons.filter_alt),
            onPressed: () {
              final filterBtnRenderObj =
                  _filterBtnKey.currentContext.findRenderObject() as RenderBox;
              Offset position = filterBtnRenderObj.localToGlobal(Offset.zero);
              Size filterBtnSize = filterBtnRenderObj.size;
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  position.dx - filterBtnSize.width,
                  position.dy,
                  position.dx,
                  position.dy + filterBtnSize.height,
                ),
                items: <PopupMenuEntry>[
                  PopupMenuItem(
                    child: FlatButton(
                      child: Text('Show all'),
                      onPressed: () {
                        _filteredItems = null;
                        setState(() {});
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: FlatButton(
                      child: Text('Show active'),
                      onPressed: () {
                        _filteredItems = _todoItems
                            .where((element) =>
                                element.isCompleted == false ||
                                element.isCompleted == null)
                            .toList();
                        setState(() {});
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: FlatButton(
                      child: Text('Show completed'),
                      onPressed: () {
                        _filteredItems = _todoItems
                            .where((element) => element.isCompleted == true)
                            .toList();
                        setState(() {});
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          PopupMenuButton(
            child: Icon(Icons.more_horiz),
            onSelected: (value) {},
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  child: FlatButton(
                    child: Text('Mark all completed'),
                    onPressed: () {
                      _todoItems = _todoItems
                          .map((e) => e.copy(isCompleted: true))
                          .toList();
                      setState(() {});
                    },
                  ),
                ),
                PopupMenuItem(
                  child: FlatButton(
                    child: Text('Mark all active'),
                    onPressed: () {
                      _todoItems = _todoItems
                          .map((e) => e.copy(isCompleted: false))
                          .toList();
                      setState(() {});
                    },
                  ),
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
