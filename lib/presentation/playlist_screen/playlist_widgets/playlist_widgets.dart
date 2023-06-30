//create new playlist popup
import 'package:flutter/material.dart';
import 'package:naromusic/domain/db/models/songsmodel.dart';

class createnewplaylist {
  createnewplaylist(this.context);
  BuildContext context;
  final _formkey = GlobalKey<FormState>();
  final _playlisttexcontroller = TextEditingController();
  void createnewolayList(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Playlist creation",
          style: TextStyle(fontFamily: "BebasNeue-Regular", fontSize: 25),
        ),
        content: Form(
          key: _formkey,
          child: TextFormField(
            decoration:
                InputDecoration(label: Text("Enter your playlist name")),
            controller: _playlisttexcontroller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the playlist name';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  _submitForm();
                  _playlisttexcontroller.clear();
                }
              },
              child: Text(
                "Create",
                style: TextStyle(color: Colors.black),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel", style: TextStyle(color: Colors.black)))
        ],
      ),
    );
  }

  void _submitForm() {
    final textValue = _playlisttexcontroller.text;
    print('textcontroller = ${textValue}');
    List<songsmodel> listarray = [];
   // addplaylisttodatabase(textValue, listarray, context);
    Navigator.pop(context);
  }
}