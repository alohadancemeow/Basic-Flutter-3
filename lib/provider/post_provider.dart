import 'package:flutter/foundation.dart';
import 'package:my_timeline_flutter_app/database/post_db.dart';
import 'package:my_timeline_flutter_app/database/post_db_sqlite.dart';
import 'package:my_timeline_flutter_app/models/post_model.dart';

class PostProvider with ChangeNotifier {
  //with = การกำหนดคุณสมบัติให้กับคลาส

  PostDB _postDB;
  List<Post> _posts = [];

  //Fat arrow function.
  List<Post> get post => _posts;

  PostProvider() {
    //set database name
    _postDB = PostDBSqlite('postDatabase');
    // _postDB = PostDB('postDatabase');
  }

  addNewPost(String postMessage) async {
    //add post to _post[]
    // _posts.add(post);

    //get post obj.
    var post = Post(message: postMessage, dateTimeCreated: DateTime.now());

    //enter name of db,
    //then save post to db
    await _postDB.save(post);

    //load all data
    var postFromDB = await _postDB.loadAllPosts();

    //set post data to _post[] (consumer)
    _posts = postFromDB;

    //notify change to all consumers
    notifyListeners();
  }

  //load data when open app.
  initData() async {
    _posts = await _postDB.loadAllPosts();
    notifyListeners();
  }

  //clear posts
  clearAllPost() async {
    await _postDB.clearPostData();

    //empty _post[]
    _posts = [];

    notifyListeners();
  }
}
