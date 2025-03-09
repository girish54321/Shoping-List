import 'package:flutter/material.dart';
import 'package:get/get_instance/src/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:local_app/app/HomeScreen/MainHomeScreen.dart';
import 'package:local_app/app/getx/SettingController.dart';
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
    GetInstance().put<SettingController>(SettingController());
    return GetMaterialApp(
      darkTheme: ThemeData(brightness: Brightness.dark),
      title: 'Flutter Demo',
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
