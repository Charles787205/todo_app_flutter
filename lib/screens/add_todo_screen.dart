import 'package:flutter/material.dart';
import "package:todo_app/components/custom_textfield.dart";
import "package:todo_app/components/time_textfield.dart";
import "package:todo_app/components/date_textfield.dart";
import "package:todo_app/components/priority_checkbox.dart";
import 'package:todo_app/utils/database_functions.dart';
import "package:todo_app/utils/objects.dart";

class AddToDoScreen extends StatefulWidget {
  final VoidCallback refreshTodos;
  AddToDoScreen({super.key, required this.refreshTodos});
  @override
  State<AddToDoScreen> createState() => _AddToDoScreen();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  @override
  void dispose() {}
}

class _AddToDoScreen extends State<AddToDoScreen> {
  bool _isNotify = false;
  String prioritySelected = '';
  String imagePath = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_double_arrow_left,
            size: 40,
          ),
          onPressed: () => (Navigator.of(context).pop()),
        ),
        centerTitle: true,
        title: CircleAvatar(
          radius: 40,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.secondary,
          child: const Icon(Icons.account_circle, color: Colors.white),
        ),
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "To do title",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              CustomTextField(
                hintText: "Task Title",
                iconData: Icons.create_outlined,
                controller: widget.titleController,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Description",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              CustomTextField(
                controller: widget.descriptionController,
                hintText: "Describe youre task in 10-30 words.",
                iconData: Icons.create_outlined,
                minlines: 3,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Date",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              DateTextField(
                controller: widget.dateController,
                hintText: "Due Date (e.g.11-20-2023)",
                iconData: Icons.create_outlined,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Time",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TimeTextField(
                controller: widget.timeController,
                hintText: "Time",
                iconData: Icons.create_outlined,
              ),
              const SizedBox(
                height: 20,
              ),
              CheckboxListTile(
                  onChanged: (bool? value) {
                    setState(() {
                      _isNotify = value!;
                    });
                  },
                  title: const Text(
                    "Notify me 30 minutes before",
                    style: TextStyle(fontSize: 11),
                  ),
                  secondary: const Icon(Icons.notifications_active),
                  value: _isNotify),
              PriorityCheckBox(
                prioritySelected: prioritySelected,
                onSelect: (String value) {
                  setState(() {
                    prioritySelected = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () async {
                  debugPrint(widget.titleController.text);
                  debugPrint(widget.descriptionController.text);
                  debugPrint(widget.dateController.text);
                  debugPrint(widget.timeController.text);
                  debugPrint(prioritySelected);
                  debugPrint(_isNotify.toString());

                  var todo = Todo(
                      title: widget.titleController.text,
                      description: widget.descriptionController.text,
                      date: widget.dateController.text,
                      time: widget.timeController.text,
                      priority: prioritySelected,
                      isNotify: _isNotify);
                  if (await addTodo(todo) && context.mounted) {
                    widget.refreshTodos();
                    Navigator.pop(context);
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary)),
                child: Text(
                  "Add Todo",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
