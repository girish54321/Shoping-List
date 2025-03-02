import 'package:flutter/material.dart';
import 'package:local_app/app/homeScreen/MainHomeScreen.dart';
import 'package:local_app/database.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final DatabaseService _databaseService = DatabaseService.INSTANCE;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local App',
      home: MainHomeScreen(),
      // home: Scaffold(
      //   appBar: AppBar(title: Text('Local App')),
      //   body: listOfTasks(),
      //   floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       addTask();
      //     },
      //   ),
      // ),
    );
  }

  // Widget listOfTasks() {
  //   return FutureBuilder(
  //     future: _databaseService.getTask(),
  //     builder: (context, snapShot) {
  //       return ListView.builder(
  //         itemCount: snapShot.data?.length ?? 0,
  //         itemBuilder: (context, index) {
  //           Task task = snapShot.data![index];
  //           return ListTile(
  //             title: Text(task.task ?? "Nice "),
  //             trailing: Checkbox(
  //               value: task.status == 1,
  //               onChanged: (val) {
  //                 _databaseService.updateTask(
  //                   task.id as int,
  //                   task.task ?? "",
  //                   task.information ?? "",
  //                   val == true ? 1 : 0,
  //                 );
  //                 setState(() {});
  //               },
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  // void addTask() {
  //   _databaseService.addTask('Task 1');
  //   setState(() {});
  // }
}
