import 'package:flutter/material.dart';
import 'package:local_app/app/AddShopingItem/AddShopingItemScreen.dart';
import 'package:local_app/app/CreateShopingList/CreateShopingList.dart';
import 'package:local_app/app/DataBase/shop-list-database.dart';
import 'package:local_app/helper.dart';
import 'package:local_app/modal/ShopingListModal.dart';

class ShopingList extends StatefulWidget {
  final bool isCompleted;
  const ShopingList({super.key, required this.isCompleted});

  @override
  State<ShopingList> createState() => _ShopingListState();
}

class _ShopingListState extends State<ShopingList> {
  final DatabaseService _databaseService = DatabaseService.INSTANCE;

  Widget listOfTasks() {
    return FutureBuilder(
      future: _databaseService.getShopingList(widget.isCompleted),
      builder: (context, snapShot) {
        if (snapShot.data?.isEmpty ?? false) {
          return Center(
            child: Text(
              !widget.isCompleted
                  ? "You Past shoping list will show here"
                  : "Create your shoping List",
              style: TextStyle(fontSize: 22),
            ),
          );
        }
        return ListView.builder(
          itemCount: snapShot.data?.length ?? 0,
          itemBuilder: (context, index) {
            ShopingListModal task = snapShot.data![index];
            return ListTile(
              leading: Icon(
                Icons.checklist_rounded,
                color: !widget.isCompleted ? Colors.green : Colors.orange,
              ),
              onTap: () {
                Helper().goToPage(
                  context: context,
                  child: AddShopingItem(shopingList: task),
                );
              },
              title: Text(task.shopingListName ?? "Nice "),
              subtitle: Text(task.shopingListInformation ?? "Nice "),
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
