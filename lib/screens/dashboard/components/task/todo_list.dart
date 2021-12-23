// import 'package:ciapp/constants.dart';
// import 'package:ciapp/models/task.dart';
// import 'package:flutter/material.dart';

// class TodoList extends StatefulWidget {
//   Task task;
//   TodoList(this.task);

//   @override
//   _TodoListState createState() => _TodoListState();
// }

// class _TodoListState extends State<TodoList> {
//   List<Todo> todos = [];
//   final TextEditingController todoController = new TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     var task = widget.task;


//     return Container(
//       width: double.infinity,
//       // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//       child: ListView.builder(
//           itemCount: todos.length,
//           itemBuilder: (context, index) {
//             var todo = todos[index];
//             return Container(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//               child: Row(
//                 children: [
//                   InkWell(
//                       onTap: () {},
//                       child: Icon(Icons.circle,
//                           color: todo.isDone ? kPrimaryColor : kSecondaryColor,
//                           size: 16)),
//                   SizedBox(width: 20),
//                   Flexible(
//                       child: TextField(
//                           onChanged: (value) {
//                             todo.todo = value;
//                           },
//                           controller: todoController,
//                           keyboardType: TextInputType.text,
//                           decoration: InputDecoration(
//                             fillColor: Colors.transparent,
//                             hintText: todo.todo ?? "Unkown todo!",
//                             hintStyle: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1
//                                 .copyWith(
//                                     color: kSecondaryColor.withOpacity(0.3)),
//                             contentPadding: EdgeInsets.all(0),
//                             border: InputBorder.none,
//                             enabledBorder: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                           ))),
//                 ],
//               ),
//             );
//           }),
//     );
//   }
// }

// class Todo {
//   String todo;
//   bool isDone;

//   Todo(this.todo, this.isDone);
// }
