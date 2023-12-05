import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
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
