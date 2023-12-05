import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'objects.dart';

//Naa diri ang functions para mag add ug data sa Database.

Future<void> addDataToFirestore(String todoText, String dueDate) async {
  try {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final user = <String, dynamic>{
      "first": "Ada",
      "last": "Lovelace",
      "born": 1815
    };

// Add a new document with a generated ID
    db.collection("users").add(user).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  } catch (e) {
    print('addDataToFirestore error');
    print(e);
  }
}

Future<bool> retrieveAndAddIfNoneUser(UserCredential userCredential) async {
  //try uf kuha sa user kung naka save sa firebase kung wala mag add ug bag.o
  try {
    FirebaseFirestore db = FirebaseFirestore.instance;

    var users = db.collection("users");
    var doc = await users.doc(userCredential.user?.uid).get();
    if (doc.exists) {
      var existingData = doc.data();
    } else {
      await users
          .doc(userCredential.user?.uid)
          .set({'nickname': '', 'image': ''});
    }

    return true;
  } catch (e) {
    print('retrieveAndAddIfNoneUser error');
    print(e);
    return false;
  }
}

Future<bool> addTodo(Todo todo) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  try {
    var todoRef = db.collection("users").doc(user!.uid).collection("todos");
    await todoRef.add(todo.toMap());
    return true;
  } catch (e) {
    print(e);
    print('addTodo error');
    return false;
  }
}

Future<List<Todo>> getTodos() async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  try {
    var todoRef = db.collection('users').doc(user!.uid).collection('todos');
    var querySnapshot = await todoRef.get();
    List<Todo> todos = [];

    querySnapshot.docs.forEach((doc) {
      var data = doc.data() as Map<String, dynamic>;

      // Use data from Firestore to create Todo objects
      Todo todo = Todo(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        time: data['time'] ?? '',
        date: data['date'] ?? '',
        isNotify: data['isNotify'] ?? false,
        priority: data['priority'] ?? '',
      );

      todos.add(todo);
    });

    return todos;
  } catch (e) {
    print('getTodos error');
    print(e);
    return [];
  }
}
