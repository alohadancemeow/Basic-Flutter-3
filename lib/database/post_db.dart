import 'dart:developer';
import 'dart:io';

import 'package:my_timeline_flutter_app/models/post_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class PostDB {
  String databaseName;

  PostDB({this.databaseName});

  //open db.
  Future<Database> openDatabase() async {
    //get path
    Directory appDocumentDirectory = await getApplicationDocumentsDirectory();

    //join path - database name
    String databaseLocationInApp =
        join(appDocumentDirectory.path, this.databaseName);

    //create database factory
    DatabaseFactory dbFactory = databaseFactoryIo;

    //open database's location
    Database db = await dbFactory.openDatabase(databaseLocationInApp);

    //return database.
    return db;
  }

  //save data to database,
  //then get the key
  Future<int> save(Post post) async {
    //start openning database
    var database = await this.openDatabase();

    //create a store
    var postStore = intMapStoreFactory.store('posts');

    //add data to store,
    //then it will return the key out
    var dataId = await postStore.add(database, Post.toJson(post));

    //close datebase
    await database.close();

    return dataId;
  }

  //load data
  Future<List<Post>> loadAllPosts() async {
    //open db
    var database = await this.openDatabase();

    //get store reference
    var postStore = intMapStoreFactory.store('posts');

    //find and get all data in store
    //wtih sortting by key.
    var snapshot = await postStore.find(database,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));

    // ignore: deprecated_member_use
    var postsList = List<Post>();

    //loop and get data from snapshot
    //then add them to postList
    for (var record in snapshot) {
      postsList.add(Post.fromRecord(record));
    }

    return postsList;
  }
}
