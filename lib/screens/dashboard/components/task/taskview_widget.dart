import 'package:ciapp/constants.dart';
import 'package:ciapp/models/task.dart';
import 'package:ciapp/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'taskview_screen.dart';

class TaskWidget extends StatefulWidget {
  final Task task;

  TaskWidget({Key key, this.task}) : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @mustCallSuper
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      height: 48,
      decoration: BoxDecoration(
        // color: widget.task.isDone ? kBackgroundColor : kSecondaryColor,
        border: BorderDirectional(
            bottom: BorderSide(
          color: kBackgroundColor.withOpacity(0.3),
          width: 0.4,
        )),
        // borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
              onTap: () {
                setState(() {
                  widget.task.isDone = !widget.task.isDone;
                  DatabaseService().updateTask(user.uid, widget.task);
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.done,
                  color: widget.task.isDone ? Colors.greenAccent : Colors.white,
                  size: 24,
                ),
              )),
          SizedBox(width: 8),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TaskViewScreen(widget.task)));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.task.title ?? "Untitled task!",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontSize: 13,
                            color: widget.task.isDone
                                ? Colors.greenAccent
                                : Colors.white,
                          )),
                  Text(widget.task.desc ?? "Unkown description!",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 12,
                            color: widget.task.isDone
                                ? Colors.greenAccent
                                : Colors.white,
                          )),
                ],
              ),
            ),
          ),
          SizedBox(width: 18),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: Text("Delete "),
                        content: Text("Are you sure you want to delete?"),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: Text("Delete"),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                        ]);
                  }).then((delete) {
                if (delete) {
                  DatabaseService().deleteTask(user.uid, widget.task);
                }
              });
            },
            child: Icon(Icons.delete,
                color: widget.task.isDone ? Colors.red : Colors.white),
          ),
        ],
      ),
    );
  }
}
