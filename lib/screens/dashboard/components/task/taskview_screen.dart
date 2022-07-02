import 'package:ciapp/constants.dart';
import 'package:ciapp/models/task.dart';
import 'package:ciapp/screens/dashboard/components/task/todo_widget.dart';
import 'package:ciapp/service/database_service.dart';
import 'package:ciapp/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TaskViewScreen extends StatefulWidget {

  Task? task;
  TaskViewScreen(this.task);

  @override
  _TaskViewScreenState createState() => _TaskViewScreenState();
}

class _TaskViewScreenState extends State<TaskViewScreen> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController descController = new TextEditingController();

  List<Todo> todosList = [];

  initState() {
    super.initState();
    _todosMapToList(widget.task!.todos as Map<String?, dynamic>?);
  }

  void _todosMapToList(Map<String?, dynamic>? todosMap) {
    todosList = [];
    if (todosMap != null) {
      int i = 0;
      todosMap.forEach(
          (k, v) => todosList.add(Todo(index: i++, todoDesc: k, isDone: v)));
    }
  }

  void _todosListToMap(List<Todo> todosList) {
    Map<String?, dynamic> newTodosMapped = {};
    for (var todo in todosList) {
      newTodosMapped[todo.todoDesc] = todo.isDone;
    }
    widget.task!.todos = newTodosMapped;
  }

  void dispose() {
    super.dispose();
    todosList = [];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var task = widget.task!;
    var user = Provider.of<User>(context);

    titleController.text = widget.task!.title!;
    descController.text = widget.task!.desc!;

    String createdAt = "Who knows!!";
    if (widget.task!.doneAt != null)
      createdAt = DateFormat('dd MMM yyyy').format(widget.task!.createdAt!);

    String doneAt = "Not done yet!";
    if (widget.task!.doneAt != null)
      doneAt = DateFormat('dd MMM yyyy').format(widget.task!.doneAt!);

    Color textColor = Colors.white;

    debugPrint(todosList.toString());

    return Scaffold(
      body: Stack(children: [
        GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SafeArea(
            child: Container(
              height:
                  SizeConfig.screenHeight! - MediaQuery.of(context).padding.top,
              // padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              color: kBackgroundColor,
              child: Column(
                children: [
                  buildTopTitleBar(context, task, user),
                  Container(
                    width: double.infinity,
                    // height: SizeConfig.screenHeight * 0.4,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      // borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text("Task Created On: $createdAt",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: textColor,
                                    fontSize: 14)),
                          ],
                        ),
                        Text("Task Done: $doneAt",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: textColor,
                              fontSize: 15,
                            )),
                        TextField(
                          keyboardType: TextInputType.text,
                          controller: descController,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18.0,
                          ),
                          onChanged: (value) {
                            task.desc = value;
                          },
                          maxLines: 4,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            fillColor: Colors.transparent,
                            hintText:
                                task.desc == "" ? "Description" : task.desc,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: ListView.builder(
                          itemCount: todosList.length,
                          itemBuilder: (context, index) {
                            return TodoWidget(
                                todo: todosList[todosList.length - index - 1],
                                onTodoChanged: (todo) {
                                  if (todo.index >= 0 &&
                                      todo.index < todosList.length)
                                    todosList[todo.index].todoDesc =
                                        todo.todoDesc;
                                  else
                                    todosList.add(todo);
                                  // setState(() {});
                                });
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 32,
          bottom: 32,
          child: Material(
            color: kPrimaryColor,
            child: InkWell(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                setState(() {
                  var newTodo = Todo(todoDesc: "New Todo", isDone: false);
                  todosList.add(newTodo..index = todosList.length);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  // border: Border.all(color: kPrimaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: EdgeInsets.all(6),
                child: Icon(Icons.add, color: kBackgroundColor, size: 32),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Container buildTopTitleBar(BuildContext context, Task task, User user) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: kPrimaryColor, size: 30),
          ),
          SizedBox(width: 20),
          Expanded(
            child: TextField(
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              controller: titleController,
              maxLines: 3,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                color: Colors.black,
              ),
              onChanged: (value) {
                task.title = value;
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                fillColor: Colors.transparent,
                hintText: task.title == "" ? "Title" : task.title,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: () {
              _todosListToMap(todosList);
              if (task.doc_id == null) {
                widget.task!.createdAt = DateTime.now();
                DatabaseService().addTask(user.uid, widget.task!);
              } else {
                if (widget.task!.isDone) widget.task!.doneAt = DateTime.now();
                DatabaseService().updateTask(user.uid, widget.task!);
              }
              Navigator.pop(context);
            },
            child: Icon(Icons.done, color: kPrimaryColor, size: 30),
          ),
        ],
      ),
    );
  }
}
