import 'package:flutter/material.dart';
import 'package:todo_app/utils/database_functions.dart';
import 'package:todo_app/utils/objects.dart';
import 'package:todo_app/screens/edit_todo_screen.dart';

class TodoDetails extends StatelessWidget {
  final Todo todo;
  Function? refreshPage;
  TodoDetails({super.key, required this.todo, this.refreshPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_double_arrow_left,
            size: 40,
          ),
          onPressed: () => (Navigator.of(context).pop()),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text("Delete To Do"),
                        elevation: 3,
                        content: Text(
                          "Are you sure you want to delete this to do?",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                deleteTodo(todo.id!);

                                Navigator.pop(context);
                                Navigator.pop(context);
                                refreshPage!();
                              },
                              child: const Text("Delete")),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ],
                      ));
            },
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => EditToDoScreen(
                          refreshTodos: () {
                            refreshPage!();
                          },
                          todo: todo)));
            },
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "To do title:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(todo.title,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.secondary)),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Description:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(todo.title,
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.secondary)),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Due date:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('${todo.date} ${todo.getWeekDay()}',
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.secondary)),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Time:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(todo.time,
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.secondary)),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  "Priority:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                    todo.priority[0].toUpperCase() + todo.priority.substring(1),
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.secondary)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
