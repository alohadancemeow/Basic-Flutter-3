import 'package:flutter/material.dart';
import 'package:my_timeline_flutter_app/pages/second_page.dart';
import 'package:my_timeline_flutter_app/provider/post_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //call when starting app.
  @override
  void initState() {
    super.initState();

    //call provider to show all data.
    Provider.of<PostProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('1st : Timeline'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // log("appbar icon clicked");
              // go to 2nd page ->
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (BuildContext context) {
                        return Secondpage();
                      }));
            },
          )
        ],
      ),
      //ผูก provider - consumer ->
      //รับข้อมูลจาก provider เข้ามาทำงาน
      body: Consumer<PostProvider>(
        builder: (BuildContext context, value, Widget child) {
          //ListView ->
          return ListView.builder(
            itemCount: value.post.length,
            itemBuilder: (context, index) {
              //get data from post[index]
              var postData = value.post[index];
              // log("$postData");

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    //Column ->
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //show timeago
                        Text(
                          postData.timeAgo,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //show messege
                        Text(
                          postData.message,
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey[350]),
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
