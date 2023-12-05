import 'package:flutter/material.dart';
import 'package:todo_app/utils/firestore.dart';
import 'components/theme.dart';
import 'components/custom_appbar.dart';
import 'components/search_field.dart';
import 'components/no_to_do.dart';
import 'components/todo_card.dart';
import 'package:todo_app/screens/all.dart';
import 'package:todo_app/utils/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:todo_app/utils/objects.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do App',
      theme: theme,

      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/addTodo': (context) => AddToDoScreen(
              refreshTodos: () {},
            )
      }, // Add this line
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<UserCredential> _signInFuture;
  late Future<List<Todo>> _todos;

  void initState() {
    super.initState();
    _initializeSignInFuture();
  }

  Future<void> _initializeSignInFuture() async {
    try {
      _signInFuture = signInWithGoogle();
      _todos = getTodos();
    } catch (error) {
      print("Error initializing sign-in: $error");
      // Handle initialization error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppbar(title: "Hello Mike"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: IntrinsicHeight(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SearchField(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.checklist,
                        size: 30,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "To do list:",
                        style: TextStyle(
                            fontSize: 30,
                            color: Theme.of(context).colorScheme.primary),
                      )
                    ],
                  ),
                  FutureBuilder<List<Todo>>(
                      future: _todos,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List<Todo> todos = snapshot.data ?? [];

                            if (todos.isEmpty) {
                              return const Column(
                                children: [
                                  SizedBox(
                                    height: 100,
                                  ),
                                  NoToDo()
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  for (Todo todo in todos)
                                    TodoCard(
                                      todoText: todo.title.length > 12
                                          ? '${todo.title.substring(0, 12)}...'
                                          : todo.title,
                                      dueDate: todo.date,
                                      onChange: (value) {},
                                    )
                                ],
                              );
                            }
                          }
                        } else {
                          return const Column(
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              CircularProgressIndicator(),
                              Text("Loading")
                            ],
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (context.mounted) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddToDoScreen(
                            refreshTodos: () {
                              setState(() {
                                _todos = getTodos();
                              });
                            },
                          )));
            }
          },
          tooltip: 'Increment',
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ));
  }
}
