import 'package:flutter/foundation.dart';
import 'package:my_timeline_flutter_app/models/post_model.dart';

class PostProvider with ChangeNotifier {
  //with = การกำหนดคุณสมบัติให้กับคลาส

  List<Post> _posts = [];

  // List<String> get post {
  //   return _posts;
  // }

  //Fat arrow function.
  List<Post> get post => _posts;

  addNewPost(String postMessage) {
    //add post to _post[]
    // _posts.add(post);

    var post = Post(message: postMessage, dateTimeCreated: DateTime.now());

    _posts.insert(0, post);

    //notify change to all consumers
    notifyListeners();
  }
}
