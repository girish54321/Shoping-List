import 'package:flutter/material.dart';
import 'package:local_app/app/CreateShopingList/CreateShopingList.dart';
import 'package:local_app/app/DataBase/shop-list-database.dart';
import 'package:local_app/helper.dart';
import 'package:local_app/modal/ShopingListModal.dart';

class ShopingList extends StatefulWidget {
  const ShopingList({super.key});

  @override
  State<ShopingList> createState() => _ShopingListState();
}

class _ShopingListState extends State<ShopingList> {
  final DatabaseService _databaseService = DatabaseService.INSTANCE;

  Widget listOfTasks() {
    return FutureBuilder(
      future: _databaseService.getShopingList(),
      builder: (context, snapShot) {
        return ListView.builder(
          itemCount: snapShot.data?.length ?? 0,
          itemBuilder: (context, index) {
            ShopingListModal task = snapShot.data![index];
            return ListTile(
              title: Text(task.shopingListName ?? "Nice "),
              subtitle: Text(task.shopingListInformation ?? "Nice "),
              trailing: Checkbox(
                value: task.state == 1,
                onChanged: (val) {
                  // _databaseService.updateTask(
                  //   task.id as int,
                  //   task.task ?? "",
                  //   task.information ?? "",
                  //   val == true ? 1 : 0,
                  // );
                  setState(() {});
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listOfTasks(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Helper().goToPage(context: context, child: Createshopinglist());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
