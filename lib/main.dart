import 'package:flutter/material.dart';
import 'package:flutter_app_new/auth/view/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // // Запрашиваем разрешение на получение уведомлений
  // await FirebaseMessaging.instance.requestPermission();

  // // Получаем FCM-токен устройства и выводим его в консоль
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // print('FCM Token: $fcmToken');

  // // Настройка обработчика для получения уведомлений во время работы приложения
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Received message while app is in the foreground!');
  //   print('Message data: ${message.data}');
  //   // Тут вы можете добавить логику для обработки уведомления при открытом приложении
  // });

  // Запуск приложения с виджетом Auth
  runApp(Auth());
}
