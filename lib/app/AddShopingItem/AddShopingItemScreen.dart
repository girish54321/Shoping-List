import 'package:flutter/material.dart';
import 'package:local_app/app/DataBase/shop-list-database.dart';
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

  TextEditingController? itemName;

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
              trailing: Checkbox(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Shopping Item'),
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
