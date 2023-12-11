import 'package:flutter/material.dart';
import 'package:todo_app/utils/database_functions.dart'; //Diri ang access sa database (Fiebase-Firestore)
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
  runApp(const MyApp());
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
  String _search = '';

  TextStyle _getPriorityStyle(String priority) {
    switch (priority) {
      case 'urgent':
        return const TextStyle(color: Colors.red);
      case 'high':
        return TextStyle(color: Theme.of(context).colorScheme.primary);
      case 'normal':
        return TextStyle(color: Theme.of(context).colorScheme.secondary);
      case 'low':
        return const TextStyle(color: Colors.white24);
      default:
        return const TextStyle(); // Default style
    }
  }

  late Future<UserCredential> _signInFuture;
  late Future<List<Todo>> _todos;
  String title = "User";
  UserAdditionalInfo? userAdditionalInfo;
  String _priority = '';
  @override
  void initState() {
    super.initState();
    _initializeSignInFuture();
    getUserAdditionalInfo().then((value) => setState(
          () {
            userAdditionalInfo = value;
            if (userAdditionalInfo?.nickname == '') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddInfoScreen(refreshScreen: getUAI)));
            } else {
              title = userAdditionalInfo!.nickname;
            }
          },
        ));
  }

  Future<void> _initializeSignInFuture() async {
    try {
      _signInFuture = signInWithGoogle();
      _todos = getTodos();
    } catch (error) {
      print(error);
    }
  }

  Future<void> getUAI() async {
    try {
      var value = await getUserAdditionalInfo();
      setState(() {
        userAdditionalInfo = value;
        if (userAdditionalInfo?.nickname == '') {
          title = 'No nickname';
        } else {
          title = userAdditionalInfo!.nickname;
        }
      });
    } catch (error) {
      // Handle the error as needed
      // ignore: avoid_print
      print('Error getting user additional info: $error');
    }
  }

  Future<List<Todo>> filterTodoByPriority(String priority) async {
    List<Todo> todos = await _todos;
    if (priority.isEmpty) {
      return _todos;
    }
    List<Todo> filteredTodos = _priority.isEmpty
        ? todos
        : todos.where((todo) => todo.priority == _priority).toList();
    return filteredTodos;
  }

  List<Todo> filterTodoBySearch(
      String userSearch, List<Todo> filteredTodosByPriority) {
    if (userSearch.isEmpty) {
      return filteredTodosByPriority;
    }
    List<Todo> filteredTodos = filteredTodosByPriority
        .where((todo) =>
            todo.title.toLowerCase().contains(userSearch.toLowerCase()))
        .toList();
    return filteredTodos;
  }

  @override
  Widget build(BuildContext context) {
    _todos = getTodos();

    return Scaffold(
        appBar: CustomAppbar(
          refreshScreen: () {
            getUAI();
          },
          title: title,
          imageUrl: userAdditionalInfo != null ? userAdditionalInfo!.image : '',
        ),
        endDrawer: Container(
          //color: Theme.of(context).scaffoldBackgroundColor,
          width: 200,
          decoration:
              BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
          child: ListView(children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(userAdditionalInfo != null
                          ? userAdditionalInfo!.image
                          : '')),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                      userAdditionalInfo != null
                          ? userAdditionalInfo!.nickname
                          : '',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ],
              ),
            ),
            ListBody(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.home_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text("Home",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold)),
                  onTap: () {
                    setState(() {
                      _priority = '';
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.star_border,
                    color: Colors.red,
                  ),
                  title: const Text(
                    "Urgent",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    setState(() {
                      _priority = 'urgent';
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                    leading: Icon(
                      Icons.star_border,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text("High",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold)),
                    onTap: () {
                      setState(() {
                        _priority = 'high';
                      });
                      Navigator.pop(context);
                    }),
                ListTile(
                    leading: Icon(
                      Icons.star_border,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    title: Text(
                      "Normal",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      setState(() {
                        _priority = 'normal';
                      });
                      Navigator.pop(context);
                    }),
                ListTile(
                  leading: const Icon(
                    Icons.star_border,
                    color: Colors.white24,
                  ),
                  title: const Text(
                    "Low",
                    style: TextStyle(
                        color: Colors.white24, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    setState(() {
                      _priority = 'low';
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ]),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: IntrinsicHeight(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SearchField(onChange: (value) {
                    setState(() {
                      _search = value;
                    });
                  }),
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
                      ),
                      const SizedBox(width: 20),
                      if (_priority.isNotEmpty)
                        Text(
                            '${_priority[0].toUpperCase()}${_priority.substring(1)}',
                            style: _getPriorityStyle(_priority)),
                    ],
                  ),
                  RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        _todos = getTodos();
                      });
                    },
                    child: FutureBuilder<List<Todo>>(
                      future: filterTodoByPriority(_priority),
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
                                  for (Todo todo
                                      in filterTodoBySearch(_search, todos))
                                    TodoCard(
                                        todo: todo,
                                        onChange: (value) {},
                                        refreshPage: () {
                                          setState(() {
                                            _todos = getTodos();
                                          });
                                        }),
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
                      },
                    ),
                  )
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
                            userImageUrl: userAdditionalInfo?.image,
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
