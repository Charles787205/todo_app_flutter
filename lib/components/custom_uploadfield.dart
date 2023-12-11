import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:todo_app/utils/database_functions_html.dart';

class CustomUploadField extends StatefulWidget {
  final String hintText;
  final IconData? iconData;
  final TextEditingController controller;
  final Function onTap;

  CustomUploadField(
      {super.key,
      required this.hintText,
      required this.iconData,
      required this.controller,
      required this.onTap});

  @override
  State<CustomUploadField> createState() => _CustomUploadFieldState();
}

class _CustomUploadFieldState extends State<CustomUploadField> {
  String _imageName = '';
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
        hintText: _imageName == '' ? widget.hintText : _imageName,
        hintStyle: const TextStyle(color: Color.fromRGBO(129, 129, 129, 1)),
        suffixIcon: Icon(widget.iconData, color: Colors.black87),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        contentPadding: const EdgeInsets.all(5),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());

        var pickedFiles = await FilePicker.platform
            .pickFiles(type: FileType.image, allowMultiple: false);
        if (pickedFiles != null) {
          widget.onTap(pickedFiles.files.first.bytes);
          setState(
            () => _imageName = pickedFiles.files.first.name,
          );
        }
      },
    );
  }
}
