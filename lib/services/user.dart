import 'package:cloud_firestore/cloud_firestore.dart';

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
}
