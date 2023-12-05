import 'package:flutter/material.dart';

class TimeTextField extends StatefulWidget {
  final String hintText;
  final IconData iconData;
  final TextEditingController controller;

  int minlines = 1;
  TimeTextField(
      {super.key,
      required this.hintText,
      required this.iconData,
      required this.controller,
      this.minlines = 1});

  @override
  State<TimeTextField> createState() => _TimeTextFieldState();
}

class _TimeTextFieldState extends State<TimeTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: TextStyle(
        color: Theme.of(context).colorScheme.tertiary,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Color.fromRGBO(129, 129, 129, 1)),
        suffixIcon: widget.minlines > 1
            ? null
            : Icon(widget.iconData, color: Colors.black87),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        contentPadding: const EdgeInsets.all(5),
      ),
      minLines: widget.minlines,
      maxLines: widget.minlines,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        TimeOfDay? time = await showTimePicker(
            context: context, initialTime: TimeOfDay.now());
        time ??= TimeOfDay.now();
        widget.controller.text = context.mounted ? time.format(context) : '';
      },
      readOnly: true,
    );
  }
}
