import 'package:local_app/app/DataBase/config.dart';
import 'package:local_app/modal/ShopingListModal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService INSTANCE = DatabaseService._construct();

  DatabaseService._construct();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    String databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "database_shop.db");
    final database = await openDatabase(
      databasePath,
      version: DB_VERSION,
      onCreate: (db, views) async {
        // Create tables if not exists
        await db.execute("""
        CREATE TABLE IF NOT EXISTS $SHOPING_LIST_TABLE_NAME (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          $SHOPING_LIST_NAME TEXT NOT NULL,
          $SHOPING_LIST_INFORMATION TEXT NOT NULL,
          $SHOPING_LIST_STATE INTEGER NOT NULL DEFAULT 0
        );
        """);
        await db.execute("""
        CREATE TABLE IF NOT EXISTS $SHOPING_LIST_ITEM (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          $SHOPING_LIST_ITEM_NAME TEXT NOT NULL,
          $SHOPING_LIST_ITEM_QUANTITY INTEGER NOT NULL,
          $SHOPING_LIST_ITEM_STATE INTEGER NOT NULL,
          $SHOPING_LIST_TABLE_NAME INTEGER NOT NULL DEFAULT 0,
          $SHOPING_LIST_ITEM_PRICE INTEGER NOT NULL DEFAULT 0
        );
        """);
      },
    );
    return database;
  }

  Future<void> addShopingListItem(ShopingLisItemtModal item) async {
    final db = await database;
    await db.insert(SHOPING_LIST_ITEM, {
      SHOPING_LIST_TABLE_NAME: item.id,
      SHOPING_LIST_ITEM_NAME: item.itemName,
      SHOPING_LIST_ITEM_QUANTITY: item.itemQuantity,
      SHOPING_LIST_ITEM_STATE: item.state,
      SHOPING_LIST_ITEM_PRICE: item.price,
    });
  }

  void addShopingList(ShopingListModal item) async {
    final db = await database;
    await db.insert(SHOPING_LIST_TABLE_NAME, {
      SHOPING_LIST_NAME: item.shopingListName,
      SHOPING_LIST_INFORMATION: item.shopingListInformation,
      SHOPING_LIST_STATE: 1,
    });
  }

  void completeShopingListItem(ShopingLisItemtModal item, int state) async {
    final db = await database;
    await db.update(
      SHOPING_LIST_ITEM,
      {SHOPING_LIST_ITEM_STATE: state},
      where: 'id =?',
      whereArgs: [item.id],
    );
  }

  Future<List<ShopingLisItemtModal>?> getShopingListItem(
    int id,
    bool isCompleted,
  ) async {
    final db = await database;

    if (isCompleted) {
      final List<Map<String, dynamic>> myTaskData = await db.query(
        SHOPING_LIST_ITEM,
        where: '$SHOPING_LIST_TABLE_NAME = ? AND $SHOPING_LIST_ITEM_STATE = 1',
        whereArgs: [id],
      );
      List<ShopingLisItemtModal> tasks =
          myTaskData.map((e) => ShopingLisItemtModal.fromMap(e)).toList();
      return tasks;
    }
    final List<Map<String, dynamic>> myTaskData = await db.query(
      SHOPING_LIST_ITEM,
      where: '$SHOPING_LIST_TABLE_NAME = ? AND $SHOPING_LIST_ITEM_STATE = 0',
      whereArgs: [id],
    );
    List<ShopingLisItemtModal> tasks =
        myTaskData.map((e) => ShopingLisItemtModal.fromMap(e)).toList();
    return tasks;
  }

  Future<List<ShopingListModal>?> getShopingList() async {
    final db = await database;
    final List<Map<String, dynamic>> myTaskData = await db.query(
      SHOPING_LIST_TABLE_NAME,
    );
    List<ShopingListModal> tasks =
        myTaskData.map((e) => ShopingListModal.fromMap(e, false)).toList();
    return tasks;
  }
  // Future<List<ShopingListModal>?> getShopingList(bool isCompleted) async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> myTaskData = await db.query(
  //     SHOPING_LIST_TABLE_NAME,
  //   );

  //   if (myTaskData.isNotEmpty) {
  //     List<Future<ShopingListModal>> futureTasks =
  //         myTaskData.map((e) async {
  //           var isNotCompleted = await getShopingListItem(e['id'], false);
  //           if (isNotCompleted!.isNotEmpty) {
  //             return ShopingListModal.fromMap(e, false);
  //           } else {
  //             return ShopingListModal.fromMap(e, true);
  //           }
  //         }).toList(); // Convert to List<Future<ShopingListModal>>

  //     List<ShopingListModal> tasks = await Future.wait(
  //       futureTasks,
  //     ); // Resolve the futures
  //     if (isCompleted) {
  //       return tasks.where((i) => i.isCompleted ?? false).toList();
  //     } else {
  //       return tasks.where((i) => i.isCompleted ?? true).toList();
  //     }
  //   } else {
  //     return [];
  //   }
  // }
}
