import 'package:flutter/material.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  List<Map<String, dynamic>> _todoList = [];

  TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('All Tasks'),
      ),
      body: _todoList.isEmpty
          ? Center(
              child: Text('No data'),
            )
          : ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                      value: _todoList[index]['isCompleted'] ?? false,
                      onChanged: (value) {
                        setState(() {
                          _todoList[index]['isCompleted'] = value;
                        });
                      }),
                  title: Text(
                    _todoList[index]['task']!,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          _editTaskDialog(context, index);
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          _deleteTask(index);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              }),
    );
  }

  //SAVE TASK
  void _saveTask() {
    setState(
      () {
        _todoList.add({'task': _taskController.text, 'isCompleted': false});
        Navigator.pop(context);
        _taskController.clear();
      },
    );
  }

  //EDIT TASK
  void _editTask(int index) {
    setState(
      () {
        _todoList[index]['task'] = _taskController.text;
        _taskController.clear();
        Navigator.pop(context);
      },
    );
  }

  //DELETE TASK
  void _deleteTask(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
  }

  //EDIT TASK
  void _editTaskDialog(BuildContext context, int index) {
    _taskController.text = _todoList[index]['task'];
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Task'),
            content: Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: _taskController,
                  decoration: InputDecoration(border: InputBorder.none),
                )),
            actions: [
              TextButton(
                onPressed: () {
                  _editTask(index);
                },
                child: Text('Update'),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              )
            ],
          );
        });
  }

  //ADD TASK
  void _addTask() {
    showDialog(
        context: context,
        builder: (index) {
          return AlertDialog(
            title: Text('Add Task here'),
            content: Container(
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all()),
              child: TextFormField(
                controller: _taskController,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Add Task here'),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _saveTask,
                    child: Text('Save'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel')),
                ],
              )
            ],
          );
        });
  }
}
