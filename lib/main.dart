import 'package:flutter/material.dart';
import 'package:inventory_management/screens/home/home_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inventory_management/screens/main_page.dart';
import 'package:inventory_management/screens/auth/login_page.dart';
import 'package:inventory_management/screens/test.dart';
import 'package:inventory_management/theme/im_theme.dart';

import 'utils/network/dio_client.dart';


void main()async {
    await GetStorage.init();
  await AppPathProvider.initPath();
  runApp(MaterialApp(
    
    debugShowCheckedModeBanner: false,
    home: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: IMTheme.lightTheme(),
      darkTheme: IMTheme.darkTheme(),
      debugShowCheckedModeBanner: false,
     
      home: MainPage(),
    );
  }
}
