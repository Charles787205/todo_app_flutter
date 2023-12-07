import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
        var image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          widget.onTap(image.path);
          setState(
            () => _imageName = image.name,
          );
        } else {}
      },
    );
  }
}
