import 'package:my_timeline_flutter_app/models/post_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class PostDBSqflite {
  // ! SQL Database.

  String databaseName;

  PostDBSqflite({this.databaseName});

  Future<sqflite.Database> openDatabase() async {
    //get user path
    var appDocumentDirectory = await getApplicationDocumentsDirectory();

    //join them
    var databaseLocationInApp =
        join(appDocumentDirectory.path, this.databaseName);

    //use sqflite to opening database's location
    var database = await sqflite.openDatabase(
      databaseLocationInApp,
      version: 1,
      onCreate: (db, version) async {
        //SQL command : create db if not exists database
        var sql =
            'CREATE TABLE IF NOT EXISTS Posts (id INTEGER PRIMARY KEY AUTOINCREMENT, message TEXT, createdDate DATETIME )';

        //run command
        await db.execute(sql);
      },
    );

    return database;
  }

  //insert data to database,
  //then get the key
  Future<int> save(Post post) async {
    var database = await this.openDatabase();
    var sql = "INSERT INTO Posts (message, createdDate) VALUES (?,?)";

    //get primay key
    var dataId = await database
        .rawInsert(sql, [post.message, post.dateTimeCreated.toIso8601String()]);

    return dataId;
  }

  //select data
  Future<List<Post>> loadAllPosts() async {
    var database = await this.openDatabase();
    var sql = " SELECT * FROM Posts ORDER BY id DESC";

    // query data <List<Map>>
    var results = await database.rawQuery(sql);

    // ignore: deprecated_member_use
    var postsList = List<Post>();

    //loop and get data,
    //then add to postList[]
    for (var dataItem in results) {
      var dataMessage = dataItem['message'];

      //get date(String) and parse back to DateTime type
      var dataCreatedDate = DateTime.tryParse(dataItem['createdDate']);

      //create post obj.
      var post = Post(message: dataMessage, dateTimeCreated: dataCreatedDate);

      //add to postList[]
      postsList.add(post);
    }

    return postsList;
  }

  //Clear data
  Future<void> clearPostData() async {
    var database = await this.openDatabase();
    var sql = "DELETE FROM Posts";

    database.execute(sql);
  }
}
