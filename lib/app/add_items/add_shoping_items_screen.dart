import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:local_app/Helper/buttons.dart';
import 'package:local_app/dataBase/shop_list_database.dart';
import 'package:local_app/helper/app_input_text.dart';
import 'package:local_app/modal/shoping_list_modal.dart';

class AddItemsScreen extends StatefulWidget {
  final int shopListId;
  final ShoppingListItemModel? shopListItem;
  const AddItemsScreen({
    super.key,
    required this.shopListId,
    this.shopListItem,
  });

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  TextEditingController? itemName = TextEditingController();
  TextEditingController? quantity = TextEditingController();
  TextEditingController? price = TextEditingController();

  final DatabaseService _databaseService = DatabaseService.databaseService;

  void updateItem() {
    var item = ShoppingListItemModel(
      id: widget.shopListItem?.id ?? 0,
      name: itemName?.text ?? widget.shopListItem?.name,
      quantity: int.parse(
        quantity?.text ?? widget.shopListItem?.quantity.toString() ?? "0",
      ),
      price: int.parse(
        price?.text ?? widget.shopListItem?.price.toString() ?? "0",
      ),
      status: widget.shopListItem?.status ?? 0,
    );
    _databaseService.updateItem(item);
    setState(() {});
    Navigator.of(context).pop();
  }

  void _addShopingItem() {
    var item = ShoppingListItemModel(
      id: widget.shopListId,
      name: itemName?.text,
      quantity: int.parse(quantity?.text ?? "0"),
      price: int.parse(price?.text ?? "0"),
      status: 0,
    );
    _databaseService.addItemToShopingList(item);
    setState(() {});
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    itemName?.text = widget.shopListItem?.name ?? "";
    quantity?.text = widget.shopListItem?.quantity?.toString() ?? "";
    price?.text = widget.shopListItem?.price?.toString() ?? "";
    super.initState();
  }

  @override
  void dispose() {
    itemName?.dispose();
    quantity?.dispose();
    price?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      title: FadeInRight(
                        duration: const Duration(milliseconds: 500),
                        child: Text("Add items"),
                      ),
                    ),
                    Column(
                      children: [
                        FadeInRight(
                          duration: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InputText(
                                  textInputType: TextInputType.name,
                                  textEditingController: itemName,
                                  password: false,
                                  hint: "Item Name",
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 140,
                                      child: InputText(
                                        textInputType: TextInputType.number,
                                        textEditingController: quantity,
                                        password: false,
                                        hint: "Quantity",
                                      ),
                                    ),
                                    SizedBox(
                                      width: 140,
                                      child: InputText(
                                        textInputType: TextInputType.number,
                                        textEditingController: price,
                                        password: false,
                                        hint: "Price",
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 22),
                                AppButton(
                                  function: () {
                                    if (widget.shopListItem != null) {
                                      updateItem();
                                      return;
                                    }
                                    _addShopingItem();
                                  },
                                  child: Center(
                                    child: Text(
                                      "Add Item",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
