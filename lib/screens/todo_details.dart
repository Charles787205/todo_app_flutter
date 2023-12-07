import 'package:flutter/material.dart';
import 'package:todo_app/utils/objects.dart';

class TodoDetails extends StatelessWidget {
  final Todo todo;
  const TodoDetails({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () {},
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
