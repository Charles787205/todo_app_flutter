import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  Function(String) onChange = (search) => {};
  SearchField({super.key, required this.onChange});
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        onChange(value);
      },
      style: TextStyle(
        color: Theme.of(context).colorScheme.tertiary,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        hintText: "Search",
        hintStyle: const TextStyle(color: Color.fromRGBO(129, 129, 129, 1)),
        prefixIcon: Icon(
          Icons.search,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(40))),
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
      ),
    );
  }
}
