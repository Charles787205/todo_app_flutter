import 'dart:html';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'objects.dart';

Future<void> uploadImageWeb(String nickname, FilePickerResult result) async {
  User? user = FirebaseAuth.instance.currentUser;
  var users = FirebaseFirestore.instance.collection("users");
  final storageRef = FirebaseStorage.instance.ref();
  final Reference imageRef =
      storageRef.child('/${DateTime.now().millisecondsSinceEpoch}.jpg');
  imageRef.putData(result.files.first.bytes!);
}
