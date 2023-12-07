import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_details.dart';
import 'package:todo_app/utils/objects.dart';

class TodoCard extends StatefulWidget {
  final Function onChange;
  final Todo todo;
  const TodoCard({super.key, required this.todo, required this.onChange});
  @override
  State<TodoCard> createState() => _TodoCardState();
}

@override
class _TodoCardState extends State<TodoCard> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => TodoDetails(todo: widget.todo))));
      },
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
        child: Row(children: [
          Checkbox(
            value: _isChecked,
            onChanged: (bool? value) {
              setState(() {
                _isChecked = value!;
                widget.onChange(_isChecked);
              });
            },
            side: BorderSide(
                width: 2, color: Theme.of(context).colorScheme.tertiary),
            checkColor: Theme.of(context).colorScheme.secondary,
            fillColor: _isChecked
                ? MaterialStateProperty.all(const Color.fromRGBO(0, 124, 50, 1))
                : const MaterialStatePropertyAll(null),
          ),
          Text(
            widget.todo.title.length > 12
                ? '${widget.todo.title.substring(0, 12)}...'
                : widget.todo.title,
            style: _isChecked
                ? const TextStyle(
                    color: Colors.black26,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.black26)
                : TextStyle(color: Theme.of(context).colorScheme.tertiary),
          ),
          const Spacer(),
          Text(
            widget.todo.date,
            style: const TextStyle(color: Colors.black26),
          ),
          const SizedBox(
            width: 30,
          )
        ]),
      ),
    );
  }
}
