import 'package:flutter/material.dart';

class TodoCard extends StatefulWidget {
  final String todoText;
  final String dueDate;
  final Function onChange;
  const TodoCard(
      {super.key,
      required this.todoText,
      required this.dueDate,
      required this.onChange});
  @override
  State<TodoCard> createState() => _TodoCardState();
}

@override
class _TodoCardState extends State<TodoCard> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
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
          widget.todoText,
          style: _isChecked
              ? const TextStyle(
                  color: Colors.black26,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.black26)
              : TextStyle(color: Theme.of(context).colorScheme.tertiary),
        ),
        const Spacer(),
        Text(
          widget.dueDate,
          style: const TextStyle(color: Colors.black26),
        ),
        const SizedBox(
          width: 30,
        )
      ]),
    );
  }
}
