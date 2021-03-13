import 'dart:io';

import 'package:my_timeline_flutter_app/database/post_db.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:path/path.dart';
import 'package:sembast_sqflite/sembast_sqflite.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class PostDBSqlite extends PostDB {
  PostDBSqlite(String databaseName) : super(databaseName);

  @override
  Future<Database> openDatabase() async {
    //get user's path
    Directory appDocumentDirectory = await getApplicationDocumentsDirectory();

    //join path - database name
    String databaseLocationInApp =
        join(appDocumentDirectory.path, this.databaseName);

    //create factory for sqlite
    var dbFactory = getDatabaseFactorySqflite(sqflite.databaseFactory);

    //open location
    var db = dbFactory.openDatabase(databaseLocationInApp);
    return db;
  }
}
