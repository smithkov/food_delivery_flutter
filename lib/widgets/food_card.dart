import 'package:flutter/material.dart';
import '../utility/constant.dart';

class FoodCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final int numberOfItems;

  FoodCard({this.name, this.imagePath, this.numberOfItems});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            Image(
              image: NetworkImage(imageUrl + "/" + imagePath),
              height: 65.0,
              width: 65.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Text(
                  "$numberOfItems Kinds",
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
