import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'objects.dart';
import 'dart:typed_data';

//Naa diri ang functions para mag add ug data sa Database.

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

    for (var doc in querySnapshot.docs) {
      print(doc.id);
      var data = doc.data();

      // Use data from Firestore to create Todo objects
      Todo todo = Todo(
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          time: data['time'] ?? '',
          date: data['date'] ?? '',
          isNotify: data['isNotify'] ?? false,
          priority: data['priority'] ?? '',
          id: doc.id);

      todos.add(todo);
    }

    return todos;
  } catch (e) {
    print('getTodos error');
    print(e);
    return [];
  }
}

Future<UserAdditionalInfo?> getUserAdditionalInfo() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      var userCollection = FirebaseFirestore.instance.collection("users");
      var doc = await userCollection.doc(user.uid).get();

      if (doc.exists) {
        // Assuming UserAdditionalInfo is a class representing user data
        UserAdditionalInfo userAdditionalInfo =
            UserAdditionalInfo.fromMap(doc.data() as Map<String, dynamic>);

        return userAdditionalInfo;
      } else {
        // User document does not exist
        return null;
      }
    } else {
      // No authenticated user
      return null;
    }
  } catch (e) {
    // Handle exceptions
    print("Error getting user: $e");
    return null;
  }
}

Future<void> uploadImage(String nickname,
    {String? imagePath, Uint8List? fileByte}) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var users = FirebaseFirestore.instance.collection("users");

      // Get the existing user document
      DocumentSnapshot userDoc = await users.doc(user.uid).get();
      if (imagePath != "") {
        final storageRef = FirebaseStorage.instance.ref();
        final Reference imageRef =
            storageRef.child('/${DateTime.now().millisecondsSinceEpoch}.jpg');

        await imageRef.putData(fileByte!);

        // Get the download URL
        final String downloadUrl = await imageRef.getDownloadURL();
        if (nickname != "") {
          await users.doc(user.uid).set({
            ...userDoc.data()!
                as Map<String, dynamic>, // Preserve existing fields
            'image': downloadUrl,
            'nickname': nickname
          });
        } else {
          await users.doc(user.uid).set({
            ...userDoc.data()!
                as Map<String, dynamic>, // Preserve existing fields
            'image': downloadUrl
          });
        }
      } else {
        await users.doc(user.uid).set({
          ...userDoc.data()!
              as Map<String, dynamic>, // Preserve existing fields
          'nickname': nickname
        });
      }

      // Update the user document in Firestore

      // Update the 'image' field while preserving existing fields

      print('Image uploaded successfully.');
    } else {
      print('No user signed in.');
    }
  } catch (e) {
    print('Error uploading image: $e');
  }
}

Future<void> deleteTodo(String id) async {
  var todoCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('todos');
  print(id);
  try {
    await todoCollection.doc(id).delete();
    print("todo deleted successfully");
  } catch (e) {
    print(e);
  }
}

Future<bool> editTodo(Todo todo) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  print(todo.toMap());
  try {
    var todoRef =
        db.collection("users").doc(user!.uid).collection("todos").doc(todo.id);
    await todoRef.set(todo.toMap());
    return true;
  } catch (e) {
    print(e);
    print('addTodo error');
    return false;
  }
}
