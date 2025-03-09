import 'package:flutter/material.dart';
import 'package:get/get_instance/src/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:local_app/app/HomeScreen/MainHomeScreen.dart';
import 'package:local_app/app/getx/ShopingListController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    GetInstance().put<ShopingListController>(ShopingListController());
    return GetMaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(brightness: Brightness.dark),
      theme: ThemeData(brightness: Brightness.dark),
      getPages: [
        GetPage(
          name: '/',
          page: () {
            return MainHomeScreen();
          },
        ),
      ],
    );
  }
}
