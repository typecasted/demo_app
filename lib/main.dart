import 'package:demo_app/UI/Screens/home_screen.dart';
import 'package:demo_app/UI/Screens/signin_screen.dart';
import 'package:demo_app/utils/user_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  print(
      '${UsersInfo().userInfo.read('username')}, ${UsersInfo().userInfo.read('email')}');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo App',
      theme: ThemeData(),
      home: UsersInfo().userInfo.read('loggedIn') != null
          ? UsersInfo().userInfo.read('loggedIn')
          ? HomeScreen()
          : SignInScreen()
          : SignInScreen(),
    );
  }
}
