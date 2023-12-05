import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData iconData;
  final TextEditingController controller;

  int minlines = 1;
  CustomTextField(
      {super.key,
      required this.hintText,
      required this.iconData,
      required this.controller,
      this.minlines = 1});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
    );
  }
}
