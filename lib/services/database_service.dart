import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService{
  static final _dbName = 'Students.db';
  static final _dbVersion = 1;
  static final _tableName = 'attendance';
  static final colId = 'ID';
  static final colName = 'Name';
  static final colClass = 'Class';
  static final colDateTime = 'Datetime';
  static final colIndexNumber = 'IndexNumber';
  //implemented using singleton
   DatabaseService._privateConstructor();
   static final DatabaseService instance = DatabaseService._privateConstructor();

   late Database _database;
   Future<Database> get database async{
     if(_database != null) return _database;
     _database = await _initializeDatabase();
     return _database;
   }

  _initializeDatabase() async{
     Directory directory = await getApplicationDocumentsDirectory();
     String path = join(directory.path, _dbName);
 await openDatabase(path, version: _dbVersion, onCreate: _onCreate);

  }



  FutureOr<void> _onCreate(Database db, int version) {
     db.execute(
       '''
       CREATE TABLE $_tableName (
       $colId INTEGER PRIMARY KEY,
       $colIndexNumber TEXT NOT NULL,
       $colName TEXT NOT NULL,
       $colClass TEXT NOT NULL,
       $colDateTime TEXT NOT NULL
       ) 
       '''
     );
  }

  Future<int> insert(Map<String, dynamic> row)async{
     Database database = await instance._database;
     return await database.insert(_tableName, row);
  }
  
  Future<List<Map<String, dynamic>>> queryAll()async{
     Database database = await instance._database;
     return await database.query(_tableName);
  }
  
  Future<int> update (Map<String, dynamic> row)async{
     Database database = await instance._database;
     int id = row[colId];
     return await database.update(_tableName, row, where: '$colId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async{
     Database database = await instance._database;
     return await database.delete(_tableName, where: '$colId = ?', whereArgs: [id]);
  }
}