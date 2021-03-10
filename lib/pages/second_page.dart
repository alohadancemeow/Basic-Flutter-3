import 'dart:developer';

import 'package:flutter/material.dart';

class Secondpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("2nd Page"),
      ),
      // Form ->
      body: Form(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                autofocus: true,
                maxLines: 3,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Enter your data"),
              ),
            ),
            Expanded(child: SizedBox()),
            SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                //Button ->
                child: OutlineButton(
                  onPressed: () {
                    log("added");
                    //Back to home ->
                    Navigator.pop(context);
                  },
                  textColor: Colors.blue,
                  borderSide: BorderSide(
                      color: Colors.blue, style: BorderStyle.solid, width: 2.0),
                  child: Text('Add'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
