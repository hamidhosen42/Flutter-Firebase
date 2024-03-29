// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_firebase/Firebase-Notifications/notification_services.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  NotificationServices notificationServices = NotificationServices();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.isTokenRefresh();

    notificationServices.getDeviceToken().then((value) {
       print('device token');
       print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
