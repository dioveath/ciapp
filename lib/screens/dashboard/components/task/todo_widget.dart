import 'package:ciapp/constants.dart';
import 'package:flutter/material.dart';

class TodoWidget extends StatefulWidget {
  final Todo todo;
  Function(Todo) onTodoChanged;

  TodoWidget({
    Key key,
    @required this.todo,
    @required this.onTodoChanged,
  }) : super(key: key);

  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  final TextEditingController todoController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textColor = widget.todo.isDone ? Colors.greenAccent : kBackgroundColor;

    todoController.text = widget.todo.todoDesc;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: kSecondaryColor,
      ),
      child: Row(
        children: [
          InkWell(
              onTap: () {
                setState(() {
                  widget.todo.isDone = !widget.todo.isDone;
                });
              },
              child: Icon(Icons.done,
                  color: widget.todo.isDone ? Colors.greenAccent : textColor,
                  size: 16)),
          SizedBox(width: 20),
          Flexible(
              child: TextField(
                  onChanged: (value) {
                    widget.todo.todoDesc = value;
                    widget.onTodoChanged(widget.todo);
                  },
                  style: TextStyle(color: textColor),
                  controller: todoController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    hintStyle: TextStyle(color: textColor.withOpacity(0.3)),
                    contentPadding: EdgeInsets.all(0),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ))),
        ],
      ),
    );
  }
}

class Todo {
  int index;
  String todoDesc;
  bool isDone;

  Todo({this.index = -1, this.todoDesc, this.isDone});
}
