import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationRepository();

  Future<void> updateNotificationToken() async {
    final User? user = auth.currentUser;

    if (user == null) return;

    log('AuthenticationRepository.updateNotificationToken: Updating notification token');

    NotificationSettings settings = await messaging.getNotificationSettings();

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      log('AuthenticationRepository.updateNotificationToken: Notification permission denied');
      return;
    }

    try {
      final String? token = await messaging.getToken();

      if (token != null) {
        print(token);

        await firestore.collection('users').doc(user.uid).set({
          "notificationToken": token,
        });
      }
    } catch (e) {
      log('AuthenticationRepository.updateNotificationToken: ${e.toString()}');
    }
  }
}
