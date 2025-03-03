import 'package:flutter/material.dart';
import 'package:local_app/DataBase/shop-list-database.dart';
import 'package:local_app/Helper/buttons.dart';
import 'package:local_app/Helper/appInputText.dart';
import 'package:local_app/modal/ShopingListModal.dart';

class Createshopinglist extends StatefulWidget {
  final ShoppingListModel? updateItem;
  const Createshopinglist({super.key, this.updateItem});

  @override
  State<Createshopinglist> createState() => _CreateshopinglistState();
}

class _CreateshopinglistState extends State<Createshopinglist> {
  TextEditingController nameController = TextEditingController();
  TextEditingController infoController = TextEditingController();

  final DatabaseService _databaseService = DatabaseService.databaseService;

  void createList() async {
    if (nameController.text.isEmpty || infoController.text.isEmpty) {
      return;
    }

    final ShoppingListModel shoppingList = ShoppingListModel(
      title: nameController.text,
      description: infoController.text,
    );

    _databaseService.createShopingList(shoppingList);

    nameController.clear();
    infoController.clear();

    Navigator.of(context).pop();
  }

  void updateShopingList() async {
    if (nameController.text.isEmpty || infoController.text.isEmpty) {
      return;
    }
    if (widget.updateItem == null) {
      return;
    }

    final ShoppingListModel updatedShoppingList = ShoppingListModel(
      id: widget.updateItem?.id,
      title: nameController.text,
      description: infoController.text,
    );

    _databaseService.updateShoplist(updatedShoppingList);

    nameController.clear();
    infoController.clear();

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    nameController.text = widget.updateItem?.title ?? "";
    infoController.text = widget.updateItem?.description ?? "";
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    infoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Shopping List')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        children: [
          InputText(
            textInputType: TextInputType.text,
            textEditingController: nameController,
            password: false,
            hint: "Name",
            onChnaged: (text) {},
          ),
          InputText(
            textInputType: TextInputType.text,
            textEditingController: infoController,
            password: false,
            hint: "Information",
            onChnaged: (text) {},
          ),
          const SizedBox(height: 14),
          AppButton(
            function: () {
              if (widget.updateItem != null) {
                updateShopingList();
              } else {
                createList();
              }
            },
            child: const Center(
              child: Text(
                "Create",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
