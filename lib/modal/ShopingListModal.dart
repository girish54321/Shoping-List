import 'package:local_app/app/DataBase/config.dart';

class ShopingListModal {
  final int? id;
  final String? shopingListName;
  final String? shopingListInformation;
  final int? state;

  ShopingListModal({
    this.id,
    this.shopingListName,
    this.shopingListInformation,
    this.state,
  });

  // Optional: Add a factory method to create a Task from a Map
  factory ShopingListModal.fromMap(Map<String, dynamic> map) {
    return ShopingListModal(
      id: map['id'] as int?,
      shopingListName: map[SHOPING_LIST_NAME] as String?,
      shopingListInformation: map[SHOPING_LIST_INFORMATION] as String?,
      state: map[SHOPING_LIST_STATE] as int?,
    );
  }
}
