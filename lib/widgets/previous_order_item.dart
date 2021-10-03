import 'package:flutter/material.dart';
import '../utility/constant.dart';
import 'package:intl/intl.dart';

class PreviousOrderItem extends StatelessWidget {
  final String id;
  final String total;
  final String refNo;
  final DateTime createdAt;

  PreviousOrderItem({this.id, this.total, this.refNo, this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            ListTile(
              title: Text(refNo),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(createdAt),
              ),
              trailing: Text(total),
            ),
          ],
        ),
      ),
    );
  }
}
