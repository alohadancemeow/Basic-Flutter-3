import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_timeline_flutter_app/provider/post_provider.dart';
import 'package:provider/provider.dart';

class Secondpage extends StatelessWidget {
  //Field variables
  final formKey = GlobalKey<FormState>();
  final massege = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Post Page"),
      ),
      // Form ->
      body: Form(
        key: formKey, //set key
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              //TextFormField ->
              child: TextFormField(
                controller: massege, //set controller
                autofocus: true,
                maxLines: 3,
                //validate condition
                validator: (value) {
                  if (value.isEmpty) {
                    return "Field cannot be empty";
                  } else if (value.length <= 6) {
                    return "Your data must be >6";
                  } else {
                    return null;
                  }
                },
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

                    //Validate textFormField ->
                    if (formKey.currentState.validate()) {
                      //get text from field
                      var fieldMassege = massege.text;
                      log(fieldMassege);

                      //create instance of PostProvider
                      var postProvider =
                          Provider.of<PostProvider>(context, listen: false);
                      //add fieldMassege to _posts[]
                      postProvider.addNewPost(fieldMassege);

                      //Back to home ->
                      Navigator.pop(context);
                    }
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
