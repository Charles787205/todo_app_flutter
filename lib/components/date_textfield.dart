import 'package:flutter/material.dart';

class DateTextField extends StatefulWidget {
  final String hintText;
  final IconData iconData;
  final TextEditingController controller;

  int minlines = 1;
  DateTextField(
      {super.key,
      required this.hintText,
      required this.iconData,
      required this.controller,
      this.minlines = 1});

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
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
      readOnly: true,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        DateTime? date = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
        );
        date ??= DateTime.now();

        String displayDate =
            "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
        if (context.mounted) {
          widget.controller.text = displayDate;
        }
      },
    );
  }
}
