import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "mydatabase.db");
    _database = await openDatabase(path, version: 2, onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE Datalist (id INTEGER PRIMARY KEY, title TEXT,  description TEXT)');
    });
    return _database;
  }

  Future<void> addlist(BuildContext context, String title, String description) async {
    Database? db = await database;
    db?.insert("Datalist", {
      'title': title,
      'description': description,
    });
    var snackBar = const SnackBar(content: Text('Data inserted successfully!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<List<Map<String, dynamic>>?> readData() async {
    Database? db = await database;
    return await db?.query("Datalist");
  }

  Future<dynamic> update(int? id, Map<String, dynamic> data, BuildContext context) async {
    Database? db = await database;
    await db?.update("Datalist", data, where: 'id = ?', whereArgs: [id]);
    var snackBar = SnackBar(content: Text('Data updated successfully!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
