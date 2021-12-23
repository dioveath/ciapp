import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialize() {
    FirebaseMessaging.onBackgroundMessage((message) async {
      print("Handling a background message!!");
  });

  }
}
