import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppbar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).colorScheme.background,
            foregroundColor: Theme.of(context).colorScheme.secondary,
            child: const Icon(Icons.account_circle, color: Colors.white),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text(
                "Have a nice day.",
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            ],
          )
        ],
      ),
      toolbarHeight: 100,
      actions: [
        IconButton(
          onPressed: () => {},
          icon: const Icon(
            Icons.menu_rounded,
            size: 35,
          ),
        )
      ],
    );
  }
}
