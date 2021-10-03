import 'package:flutter/material.dart';

class AllergyBox extends StatelessWidget {
  final String phone;
  AllergyBox({this.phone});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Do you have a food allergy?"),
              content: Text(
                  "If you have a fod allergy or intolerance (or someone you're ordering for has), phone the seller on ${phone}. Do not order if you cannot get the allergy information you need."),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text("okay"),
                ),
              ],
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                Icons.info_outline_rounded,
                color: Colors.blue,
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text(
                  'If you or someone you are ordering for has a food allergy or intolerance, tap here.',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blue[900],
                  ),
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ));
  }
}
