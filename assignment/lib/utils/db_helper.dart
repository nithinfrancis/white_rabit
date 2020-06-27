import 'package:assignment/employee_list/data_classes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper{

  static const String DATABASE_NAME = "db_employee.db";
  static const int DATABASE_VERSION = 1;
  static Database _db;

  static dbhOpenDatabase() async {
    _db = await openDatabase(
      join(await getDatabasesPath(),DATABASE_NAME),
      onCreate: (db, version) {
        return db.execute(
          Employee.createTable(),
        );
      },
      version: 1,
    );
  }

  static Future<int> dbhInsert(String tableName, Map<String, dynamic> values) async {
    int insertedId = -1;
    try{
      if (null == _db) {
        await DBHelper.dbhOpenDatabase();
      }
      insertedId = await _db.insert(
        tableName,
        values,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print("$insertedId");
    }catch(e){
      print(e);
    }
    return insertedId;
  }

  static Future<List<Map>> dbhQuery(String table,
      {bool distinct,
        List<String> columns,
        String where,
        List whereArgs,
      }) async {
    if (null == _db) {
      await DBHelper.dbhOpenDatabase();
    }
    return await _db.query(table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
    );
  }
}