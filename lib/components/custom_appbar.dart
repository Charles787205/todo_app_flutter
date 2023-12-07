import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_info_screen.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String imageUrl;
  void Function() refreshScreen;
  CustomAppbar(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.refreshScreen});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (context.mounted) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddInfoScreen(refreshScreen: refreshScreen)));
              }
            },
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).colorScheme.background,
              foregroundColor: Theme.of(context).colorScheme.secondary,
              backgroundImage: imageUrl != '' ? NetworkImage(imageUrl) : null,
              child: imageUrl == ''
                  ? const Icon(Icons.account_circle, color: Colors.white)
                  : null,
            ),
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
          onPressed: () => {Scaffold.of(context).openEndDrawer()},
          icon: const Icon(
            Icons.menu_rounded,
            size: 35,
          ),
        )
      ],
    );
  }
}
