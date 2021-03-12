import 'package:flutter/foundation.dart';
import 'package:my_timeline_flutter_app/database/post_db.dart';
import 'package:my_timeline_flutter_app/models/post_model.dart';

class PostProvider with ChangeNotifier {
  //with = การกำหนดคุณสมบัติให้กับคลาส

  List<Post> _posts = [];

  // List<String> get post {
  //   return _posts;
  // }

  //Fat arrow function.
  List<Post> get post => _posts;

  addNewPost(String postMessage) async {
    //add post to _post[]
    // _posts.add(post);

    //get post obj.
    var post = Post(message: postMessage, dateTimeCreated: DateTime.now());

    //enter name of db,
    //then save post to db
    var postDb = PostDB(databaseName: 'postDatabase');
    await postDb.save(post);

    //load all data
    var postFromDB = await postDb.loadAllPosts();
    // log("$postFromDB");

    //set post data to _post[] (consumer)
    _posts = postFromDB;

    //notify change to all consumers
    notifyListeners();
  }

  //load data when open app.
  initData() async {
    //database reference
    var postDB = PostDB(databaseName: 'postDatabase');
    _posts = await postDB.loadAllPosts();
    notifyListeners();
  }

  //clear posts
  clearAllPost() async {
    var postDb = PostDB(databaseName: 'postDatabase');
    await postDb.clearPostData();

    //empty _post[]
    _posts = [];

    notifyListeners();
  }
}
