import 'package:local_app/app/DataBase/config.dart';

class ShopingListModal {
  final int? id;
  final String? shopingListName;
  final String? shopingListInformation;
  final int? state;
  final bool? isCompleted;

  ShopingListModal({
    this.id,
    this.shopingListName,
    this.shopingListInformation,
    this.state,
    this.isCompleted,
  });

  // Optional: Add a factory method to create a Task from a Map
  factory ShopingListModal.fromMap(Map<String, dynamic> map, isCompleted) {
    return ShopingListModal(
      id: map['id'] as int?,
      shopingListName: map[SHOPING_LIST_NAME] as String?,
      shopingListInformation: map[SHOPING_LIST_INFORMATION] as String?,
      state: map[SHOPING_LIST_STATE] as int?,
      isCompleted: isCompleted,
    );
  }
}

class ShopingLisItemtModal {
  final int? id;
  final String? itemName;
  final int? itemQuantity;
  final int? state;
  final int? price;

  ShopingLisItemtModal({
    this.id,
    this.itemName,
    this.itemQuantity,
    this.state,
    this.price,
  });

  // Optional: Add a factory method to create a Task from a Map
  factory ShopingLisItemtModal.fromMap(Map<String, dynamic> map) {
    return ShopingLisItemtModal(
      id: map['id'] as int?,
      itemName: map[SHOPING_LIST_ITEM_NAME] as String?,
      itemQuantity: map[SHOPING_LIST_ITEM_QUANTITY] as int?,
      state: map[SHOPING_LIST_ITEM_STATE] as int?,
      price: map[SHOPING_LIST_ITEM_PRICE] as int?,
    );
  }
}
