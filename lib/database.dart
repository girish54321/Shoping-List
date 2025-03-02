// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// String TABLE_NAME = "TASK";
// String TASK_NAME = "TASK_NAME";
// String TASK_DESCRIPTION = "TASK_DESCRIPTION";
// String TASK_STATE = "STACK_STATE";
// int DB_VERSION = 1;

// class DatabaseService {
//   static Database? _db;
//   static final DatabaseService INSTANCE = DatabaseService._construct();

//   DatabaseService._construct();

//   Future<Database> get database async {
//     if (_db != null) return _db!;
//     _db = await getDatabase();
//     return _db!;
//   }

//   Future<Database> getDatabase() async {
//     String databaseDirPath = await getDatabasesPath();
//     final databasePath = join(databaseDirPath, "database_shop.db");
//     final database = await openDatabase(
//       databasePath,
//       version: DB_VERSION,
//       onCreate: (db, views) {
//         // Create tables if not exists
//         db.execute("""
//         CREATE TABLE IF NOT EXISTS $TABLE_NAME (
//           id INTEGER PRIMARY KEY AUTOINCREMENT,
//           $TASK_NAME TEXT NOT NULL,
//           $TASK_DESCRIPTION TEXT NOT NULL,
//           $TASK_STATE INTEGER NOT NULL
//         );
//         """);
//       },
//     );
//     return database;
//   }

//   void addTask(String item) async {
//     final db = await database;
//     await db.insert(TABLE_NAME, {
//       TASK_NAME: item,
//       TASK_DESCRIPTION: "No description",
//       TASK_STATE: 0,
//     });
//   }

//   Future<List<Task>?> getTask() async {
//     final db = await database;
//     final List<Map<String, dynamic>> myTaskData = await db.query(TABLE_NAME);
//     List<Task> tasks = myTaskData.map((e) => Task.fromMap(e)).toList();
//     return tasks;
//   }

//   void updateTask(
//     int taskId,
//     String task,
//     String description,
//     int status,
//   ) async {
//     final db = await database;
//     await db.update(
//       TABLE_NAME,
//       {TASK_NAME: task, TASK_DESCRIPTION: description, TASK_STATE: status},
//       where: "id = ?",
//       whereArgs: [taskId],
//     );
//   }
// }
