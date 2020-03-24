import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import './notes.dart';
import 'dart:async';
import 'dart:io';

class DatabaseHelper {
static DatabaseHelper databaseHelper ;
static Database database;
String tablename = 'database';
String colid = 'id';
String colcontent = 'content';
String coldate = 'date_created';

DatabaseHelper.createInstance();
factory DatabaseHelper(){
  if(databaseHelper == null){
    databaseHelper = DatabaseHelper.createInstance();
  }
  return databaseHelper; 
}
Future<Database> get databs async {
  if(database == null){
    database = await intializeDatabase();
  }
  return database;
}
Future<Database> intializeDatabase() async{
  Directory directory = await getApplicationDocumentsDirectory();
  String path = directory.path + 'notes.db';
  var notesdb = await openDatabase(path, version: 1, onCreate: createDb);
  return notesdb;
}
 void createDb(Database db,int newversion ) async{
   await db.execute('CREATE TABLE $tablename($colid INTEGER PRIMARY KEY AUTOINCREMENT , $coldate TEXT , $colcontent DOUBLE)');
 }
 Future<List<Map<String, dynamic>>> getNoteMapList() async {
   Database db = await this.databs;

  //  var result = await db.rawQuery('SELECT * FROM $tablename ');
   var result = await db.query(tablename);
   return result;
 }
 Future<int> inserts(Note note) async {
   Database db = await this.databs;
   var result = await db.insert(tablename, note.toMap());
   return result;
 }
 Future<int> updates(Note note) async {
   Database db = await this.databs;
   var result = await db.update(tablename, note.toMap(), where:'$colid = ?' , whereArgs: [note.id]);
   return result;
 }
 Future<int> deletes(int id) async {
   Database db = await this.databs;
   var result = await db.rawDelete('DELETE  FROM $tablename WHERE $colid = $id');
   return result;
 }
  Future<int> getcount() async{
    Database db = await this.databs;
    List<Map<String,dynamic>> x = await db.rawQuery('SELECT COUNT(*) FROM $tablename');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
  Future<List<Note>> getNotelist() async {
    var notemap = await getNoteMapList();
    int count = notemap.length;

    List<Note> notelist = List<Note>();
    for (int i=0; i<count; i++){
      notelist.add(Note.fromMap(notemap[i]));
    }
    return notelist;
  }

}