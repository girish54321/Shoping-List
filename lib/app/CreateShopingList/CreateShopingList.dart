import 'package:flutter/material.dart';
import 'package:local_app/app/DataBase/shop-list-database.dart';
import 'package:local_app/app/buttons.dart';
import 'package:local_app/appInputText.dart';
import 'package:local_app/modal/ShopingListModal.dart';

class Createshopinglist extends StatefulWidget {
  const Createshopinglist({super.key});

  @override
  State<Createshopinglist> createState() => _CreateshopinglistState();
}

class _CreateshopinglistState extends State<Createshopinglist> {
  TextEditingController nameController = TextEditingController();
  TextEditingController infoController = TextEditingController();

  final DatabaseService _databaseService = DatabaseService.INSTANCE;

  void createList() async {
    if (nameController.text.isEmpty || infoController.text.isEmpty) {
      return;
    }

    final ShopingListModal shoppingList = ShopingListModal(
      shopingListName: nameController.text,
      shopingListInformation: infoController.text,
    );

    _databaseService.addShopingList(shoppingList);

    nameController.clear();
    infoController.clear();

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Shopping List')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        children: [
          InputText(
            textInputType: TextInputType.none,
            textEditingController: nameController,
            password: false,
            hint: "Name",
            onChnaged: (text) {},
          ),
          InputText(
            textInputType: TextInputType.none,
            textEditingController: infoController,
            password: false,
            hint: "Information",
            onChnaged: (text) {},
          ),
          const SizedBox(height: 14),
          AppButton(
            function: createList,
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
