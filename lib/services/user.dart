import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class UserService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createUser(uid, name, email) {
    _firestore.collection("users").doc(uid).set({
      "name": name,
      "email": email,
      "imageURL": "https://via.placeholder.com/150",
      "createdAt": FieldValue.serverTimestamp()
    });
  }

  void updateCurrentUser(obj) {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    _firestore.collection("users").doc(uid).update(obj);
  }
}
