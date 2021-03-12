import 'package:flutter/material.dart';
import 'package:my_timeline_flutter_app/pages/home_page.dart';
import 'package:my_timeline_flutter_app/pages/setting_page.dart';
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
  @override
  Widget build(BuildContext context) {
    //TabController ->
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          //TabBarView ->
          body: TabBarView(
            children: [
              //tab 1 ->
              HomePage(),
              //tab 2 ->
              SettingPage()
            ],
          ),
          backgroundColor: Colors.blue,
          //TabBar ->
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.list),
                text: 'Timeline',
              ),
              Tab(
                text: 'Settings',
                icon: Icon(Icons.settings),
              )
            ],
          ),
        ));
  }
}
