import 'package:flutter/material.dart';

// Display the Nothing to do image with Text :)
class NoToDo extends StatelessWidget {
  const NoToDo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('images/nothing_to_do.png'),
          ),
          Text(
            "Nothing To do Here",
            style: TextStyle(
                fontSize: 20, color: Theme.of(context).colorScheme.secondary),
          )
        ],
      ),
    );
  }
}
