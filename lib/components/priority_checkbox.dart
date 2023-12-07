import 'package:flutter/material.dart';

class PriorityCheckBox extends StatefulWidget {
  String prioritySelected = '';
  Function? onSelect;

  PriorityCheckBox(
      {super.key, required this.prioritySelected, required this.onSelect});

  @override
  State<PriorityCheckBox> createState() => _PriorityCheckBoxState();
}

class _PriorityCheckBoxState extends State<PriorityCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Checkbox(
              side: const BorderSide(color: Colors.red),
              checkColor: Colors.white70,
              fillColor: widget.prioritySelected == 'urgent'
                  ? MaterialStateProperty.all(Colors.red)
                  : null,
              value: widget.prioritySelected == 'urgent',
              onChanged: (bool? value) {
                widget.onSelect!('urgent');
              }),
        ),
        Text("Urgent",
            style: TextStyle(
                fontSize: 10, color: Theme.of(context).colorScheme.secondary)),
        Flexible(
          child: Checkbox(
              checkColor: Colors.white70,
              value: widget.prioritySelected == 'high',
              onChanged: (bool? value) {
                widget.onSelect!('high');
              }),
        ),
        Text("High",
            style: TextStyle(
                fontSize: 10, color: Theme.of(context).colorScheme.secondary)),
        Flexible(
          child: Checkbox(
              side: const BorderSide(color: Colors.white70),
              checkColor: Colors.black45,
              fillColor: widget.prioritySelected == 'normal'
                  ? MaterialStateProperty.all(Colors.white70)
                  : null,
              value: widget.prioritySelected == 'normal',
              onChanged: (bool? value) {
                widget.onSelect!('normal');
              }),
        ),
        Text("Normal",
            style: TextStyle(
                fontSize: 10, color: Theme.of(context).colorScheme.secondary)),
        Flexible(
          child: Checkbox(
              side: const BorderSide(color: Colors.white24),
              checkColor: Colors.white70,
              fillColor: widget.prioritySelected == 'low'
                  ? MaterialStateProperty.all(Colors.white24)
                  : null,
              value: widget.prioritySelected == 'low',
              onChanged: (bool? value) {
                widget.onSelect!('low');
              }),
        ),
        Text("Low",
            style: TextStyle(
                fontSize: 10, color: Theme.of(context).colorScheme.secondary)),
      ],
    );
  }
}
