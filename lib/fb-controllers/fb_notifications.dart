// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// // typedef BackgroundMessageHandler = Future<void> Function(RemoteMessage message);
// // لاستقبال التنبيهات في حالة كان التطبيق في ال background 
// // RemoteMessage مرجع ما يصل من الفيربيز كمحتوى تنبيه 
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage remoteMessage) async{
//   await Firebase.initializeApp();
//   // BACKGROUND Notifications - IOS & Android
//   print('Message: ${remoteMessage.messageId}');
// }

// // قنوات استقبال للتنبيهات وعمل مجموعة للتنبيهات المرسلة الخاصة بالتطبيق
// late AndroidNotificationChannel channel;
// late FlutterLocalNotificationsPlugin localNotificationsPlugin;

// mixin FbNotifications {
//   ///CALLED IN main function between ensureInitialized <-> runApp(wedgit);
//   static Future<void> initNotifications() async{
//     // connect the previous created function with onBackgroundMessage to enable
//     // receiving notification when app in Background.
//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

//     // channel
//     if(!kIsWeb){
//       channel = const AndroidNotificationChannel(
//         'Notes_notifications_channel',
//         'News Notifications Channel',
//         description: 'This channel will receive notifications specific to news-app',
//         importance: Importance.high,
//         enableLights: true,
//         enableVibration: true,
//         ledColor: Colors.orange,
//         showBadge: true,
//         playSound: true,
//       );
//     }

//     // Flutter Local Notifications Plugin (FOREGROUND) - ANDROID CHANNEL
//     localNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     await localNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>()
//                   ?.createNotificationChannel(channel);

//     // iOS notification Setup (FOREGROUND)
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }

//   // iOS Notificatios Permission
//   Future<void> requestNotificationPermissions() async{
//     print('requestNotificationPermissions');
//     NotificationSettings notificationSettings =await 
//       FirebaseMessaging.instance.requestPermission(
//         alert: true,
//         badge: true,
//         sound: true,
//         carPlay: false,
//         announcement: false,
//         provisional: false,
//         criticalAlert: false,
//     );
//     if(notificationSettings.authorizationStatus == AuthorizationStatus.authorized){
//       print('GRANT PERMISSION');
//     }else if(notificationSettings.authorizationStatus == AuthorizationStatus.denied){
//       print('Permission Denied');
//     }
//   }

//   void initializeForgroundNotificationForAndriod(){
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Message Received: ${message.messageId}');
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? androidNotification = notification?.android;
//       if(notification != null && androidNotification !=null){
//         localNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel.id,
//               channel.name,
//               channelDescription: channel.description,
//               icon: 'launch_background'
//             )
//           )
//         );
//       }
//     });
//   }

//   // GENERAL (Android & iOS)
//   void manageNotificationAction(){
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       _controlNotificationNavigation(message.data);
//     });
//   }

//   void _controlNotificationNavigation(Map<String, dynamic> data){
//     print('Data: $data');
//     if(data['page'] != null){
//       switch (data['page']){
//         case 'products':
//           var productId = data['id'];
//           print('Product Id: $productId');
//           break;
//         case 'settings':
//           print('Navigate to settings');
//           break;
//         case 'profile':
//           print('Navigate to profile');
//           break;
//       }
//     }
//   }
// }