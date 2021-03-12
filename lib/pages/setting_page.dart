import 'package:flutter/material.dart';
import 'package:my_timeline_flutter_app/provider/post_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),

        //delete button ->
        child: RaisedButton(
          onPressed: () {
            //show dailog
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Delete Dialog'),
                  content: Text('Are you sure you want to delete ?'),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          //delete
                          Provider.of<PostProvider>(context, listen: false)
                              .clearAllPost();
                          //close dialog
                          Navigator.pop(context);
                        },
                        child: Text('Yes, I am')),
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    )
                  ],
                );
              },
            );
          },
          child: Text('Delete'),
        ),
      ),
    );
  }
}
