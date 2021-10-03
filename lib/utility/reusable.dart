import 'package:flutter/material.dart';

class Reusable{

  static dynamic inputDecoration(IconData icon, Color color, hintText){

    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      icon: Icon(
        icon,
        color: color,
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.grey,
      ),

    );

  }

}