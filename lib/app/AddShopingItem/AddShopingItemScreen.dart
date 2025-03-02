import 'package:flutter/material.dart';
import 'package:local_app/app/AddItems/AddItemsScreen.dart';
import 'package:local_app/app/CreateShopingList/CreateShopingList.dart';
import 'package:local_app/app/DataBase/shop-list-database.dart';
import 'package:local_app/helper.dart';
import 'package:local_app/modal/ShopingListModal.dart';

class AddShopingItem extends StatefulWidget {
  final ShopingListModal shopingList;
  const AddShopingItem({super.key, required this.shopingList});

  @override
  State<AddShopingItem> createState() => _AddShopingItemState();
}

class _AddShopingItemState extends State<AddShopingItem>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final DatabaseService _databaseService = DatabaseService.INSTANCE;

  TextEditingController? itemName = TextEditingController();

  void _addShopingItem(String itemName) {
    var item = ShopingLisItemtModal(
      id: widget.shopingList.id,
      itemName: itemName,
      itemQuantity: 1,
      price: 0,
      state: 0,
    );
    _databaseService.addShopingListItem(item);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    itemName?.dispose();
    super.dispose();
  }

  Widget listOfItem(bool isCompletedList) {
    return FutureBuilder(
      future: _databaseService.getShopingListItem(
        widget.shopingList.id ?? 0,
        isCompletedList,
      ),
      builder: (context, snapShot) {
        return ListView.builder(
          itemCount: (snapShot.data?.length ?? 0) + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ListTile(
                trailing: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                title: TextField(
                  controller: itemName,
                  textInputAction: TextInputAction.go,
                  onSubmitted: (value) {
                    _addShopingItem(value);
                    itemName?.text = "";
                  },
                  decoration: InputDecoration(
                    labelText: "Enter your item name",
                  ),
                ),
              );
            }
            ShopingLisItemtModal item = snapShot.data![index - 1];
            return ListTile(
              title: Text(item.itemName ?? "Nice "),
              subtitle:
                  item.itemQuantity != null
                      ? Text("Quantity: ${item.itemQuantity?.toString()}")
                      : null,
              trailing: openPopUpMenu(item),
              leading: Checkbox(
                value: item.state == 1,
                onChanged: (val) {
                  _databaseService.completeShopingListItem(
                    item,
                    val == true ? 1 : 0,
                  );
                  setState(() {});
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget openPopUpMenu(ShopingLisItemtModal? item) {
    return PopupMenuButton<String>(
      onSelected: (val) {
        if (val == "edit") {
          if (item != null) {
            Helper().goToPage(
              context: context,
              child: AddItemsScreen(
                shopListId: widget.shopingList.id ?? 0,
                shopListItem: item,
              ),
            );
          } else {
            Helper().goToPage(
              context: context,
              child: Createshopinglist(updateItem: widget.shopingList),
            );
          }
        }
        if (val == "delete") {
          if (item != null) {
            _databaseService.deleteItem(item.id ?? 0);
          } else {
            _databaseService.deleteShopList(widget.shopingList.id ?? 0);
            Navigator.of(context).pop();
          }
          setState(() {});
          return;
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          AppMenuItem(
            "edit",
            const ListTile(leading: Icon(Icons.edit), title: Text("Edit")),
          ),
          AppMenuItem(
            "delete",
            const ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text("Delete"),
            ),
          ),
        ].map((AppMenuItem choice) {
          return PopupMenuItem<String>(value: choice.id, child: choice.widget);
        }).toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Shopping Item'),
        actions: [
          IconButton(
            onPressed: () {
              Helper().goToPage(
                context: context,
                child: AddItemsScreen(shopListId: widget.shopingList.id ?? 0),
              );
            },
            icon: Icon(Icons.add),
          ),
          openPopUpMenu(null),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(icon: Icon(Icons.check)),
            Tab(icon: Icon(Icons.check_circle_outline)),
          ],
        ),
      ),
      // body: listOfItem(),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[listOfItem(false), listOfItem(true)],
      ),
      bottomNavigationBar: SafeArea(
        child: ListTile(
          title: Text(widget.shopingList.shopingListName ?? ""),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.card_travel),
              Padding(padding: EdgeInsets.only(left: 6), child: Text("209/-")),
            ],
          ),
        ),
      ),
    );
  }
}
