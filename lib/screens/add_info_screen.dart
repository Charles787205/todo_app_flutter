import 'package:flutter/material.dart';

import 'package:todo_app/components/custom_textfield.dart';
import 'package:todo_app/components/custom_uploadfield.dart';
import 'package:todo_app/utils/database_functions.dart';

class AddInfoScreen extends StatefulWidget {
  void Function() refreshScreen;
  AddInfoScreen({super.key, required this.refreshScreen});

  @override
  State<AddInfoScreen> createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {
  TextEditingController nicknameController = TextEditingController();
  String imagePath = '';
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Let's get your task done!")),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(
                    image: AssetImage("images/signup_img.png"),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text(
                          "TaskHub",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      // \u2022 - bullet unicode
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\u2022 Efficient",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\u2022 Reliable",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\u2022 Effective",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\u2022 Accessible",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\u2022 Organized",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? Column(
                      children: [
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            strokeWidth: 10,
                            semanticsLabel: "Uploading...",
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text("Uploading...",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary))
                      ],
                    )
                  : Column(children: [
                      CustomTextField(
                          hintText: "Enter Nickname",
                          iconData: null,
                          controller: nicknameController),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomUploadField(
                        hintText: "Upload Image here",
                        iconData: Icons.upload,
                        controller: TextEditingController(),
                        onTap: (String returnPath) {
                          setState(() {
                            imagePath = returnPath;
                          });
                        },
                      ),
                      const SizedBox(height: 50),
                      TextButton(
                        onPressed: () async {
                          if (imagePath != '' ||
                              nicknameController.text != '') {
                            setState(() {
                              _isLoading = true;
                            });
                            await uploadImage(
                                imagePath, nicknameController.text);
                            widget.refreshScreen();
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          }
                        },
                        style: ButtonStyle(
                          fixedSize:
                              const MaterialStatePropertyAll(Size(150, 25)),
                          backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).colorScheme.primary),
                        ),
                        child: Text("Submit",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontWeight: FontWeight.bold)),
                      )
                    ]),
            ],
          ),
        ),
      ),
    );
  }
}
