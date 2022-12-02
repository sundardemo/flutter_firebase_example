import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebaselearning/services/auth.dart';
import 'package:firebaselearning/services/user.dart';

class PushNotificationService {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  registerToken() async {
    var token = await _firebaseMessaging.getToken();
    print(token);

    //UserService().updateCurrentUser({"pushToken": token});
  }

  handleNotification() {
    FirebaseMessaging.onMessage.listen((event) {
      print(event.notification!.title);
      print(event.notification!.body);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print(event.notification!.title);
      print(event.notification!.body);
    });
  }
}
