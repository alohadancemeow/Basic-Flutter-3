import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:my_timeline_flutter_app/pages/second_page.dart';
import 'package:my_timeline_flutter_app/provider/post_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() {
  //set timeago to thai.
  timeago.setLocaleMessages("th", timeago.ThMessages());
  timeago.setLocaleMessages("th_short", timeago.ThShortMessages());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //add MultiProvider ->
    return MultiProvider(
      //set up provder
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return PostProvider();
          },
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter : My Timeline'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              log("appbar icon clicked");
              // go to 2nd page ->
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
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
