import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'collection.dart';
import 'item.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "database.db");

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE IF NOT EXISTS collections ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "description TEXT,"
          "tag TEXT,"
          "keyPhoto TEXT,"
          "layout TEXT"
          ")");
    });
  }

  void createItemTable(tableItems) async {
    await _database.execute("CREATE TABLE IF NOT EXISTS $tableItems ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "description TEXT,"
          "tag TEXT,"
          "keyPhoto TEXT,"
          "layout TEXT"
          ")"
    );
    return;
  }

  insertCollection(Collection collection) async {
    final db = await database;
    createItemTable(collection.name);
    var res = await db.insert(
      "collections",
      collection.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  Future<void> insertItem(String tableItems, Item item) async {
    final Database db = await database;

    await db.insert(
      tableItems,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Collection>> getAllCollections() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query("collections");

    return List.generate(maps.length, (i) {
      return Collection(
          id: maps[i]['id'],
          name: maps[i]['name'],
          description: maps[i]['description'],
          tag: maps[i]['tag'],
          keyPhoto: maps[i]['keyPhoto'],
          layout: maps[i]["layout"]);
    });
  }

  Future<List<Item>> getAllItems(tableItems) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableItems);

    return List.generate(maps.length, (i) {
      return Item(
          id: maps[i]['id'],
          name: maps[i]['name'],
          description: maps[i]['description'],
          tag: maps[i]['tag'],
          keyPhoto: maps[i]['keyPhoto'],
          layout: maps[i]["layout"]);
    });
  }

  Future<Collection> getCollectionById(int id) async {
    final db = await database;
    var result = await db.query("Collections", where: "id = ", whereArgs: [id]);
    return result.isNotEmpty ? Collection.fromMap(result.first) : Null;
  }

  Future<Item> getItemById(int id, String tableItems) async {
    final db = await database;
    var result = await db.query(tableItems, where: "id = ", whereArgs: [id]);
    return result.isNotEmpty ? Item.fromMap(result.first) : Null;
  }

  Future<Item> getItemByName(String name, String tableItems) async {
    final db = await database;
    var result = await db.query(tableItems, where: "name = ", whereArgs: [name]);
    return result.isNotEmpty ? Item.fromMap(result.first) : Null;
  }

  updateCollection(Collection collection) async {
    final db = await database;
    var result = await db.update("Collections", collection.toMap(),
        where: "id = ?", whereArgs: [collection.id]);
    return result;
  }

  updateItem(Item item, String tableItems) async {
    final db = await database;
    var result = await db.update(tableItems, item.toMap(),
        where: "id = ?", whereArgs: [item.id]);
    return result;
  }

  deleteCollection(int id) async {
    final db = await database;
    db.delete("Collections", where: "id = ?", whereArgs: [id]);
  }

  deleteItem(int id, String tableItems) async {
    final db = await database;
    db.delete(tableItems, where: "id = ?", whereArgs: [id]);
  }
}
