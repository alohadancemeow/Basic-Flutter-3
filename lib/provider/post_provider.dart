import 'package:flutter/foundation.dart';

class PostProvider with ChangeNotifier {
  //with = การกำหนดคุณสมบัติให้กับคลาส

  List<String> _posts = [];

  // List<String> get post {
  //   return _posts;
  // }

  //Fat arrow function.
  List<String> get post => _posts;

  addNewPost(String post) {
    //add post to _post[]
    // _posts.add(post);

    _posts.insert(0, post);

    //notify change to all consumers
    notifyListeners();
  }
}
