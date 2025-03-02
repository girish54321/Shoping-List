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
      },
    );
    return database;
  }

  void addShopingList(ShopingListModal item) async {
    final db = await database;
    await db.insert(SHOPING_LIST_TABLE_NAME, {
      SHOPING_LIST_NAME: item.shopingListName,
      SHOPING_LIST_INFORMATION: item.shopingListInformation,
      SHOPING_LIST_STATE: 1,
    });
  }

  Future<List<ShopingListModal>?> getShopingList() async {
    final db = await database;
    final List<Map<String, dynamic>> myTaskData = await db.query(
      SHOPING_LIST_TABLE_NAME,
    );
    List<ShopingListModal> tasks =
        myTaskData.map((e) => ShopingListModal.fromMap(e)).toList();
    return tasks;
  }
}
