import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../services/api_service.dart';
import 'package:intl/intl.dart';
import "../widgets/prevOrder.dart";

class PreviousOrderPage extends StatelessWidget {
  ApiService api = ApiService();
  static String routeName = "previousOrderPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Orders'),
      ),
      body: Center(
        child: PrevOrder(),
      ),
    );
  }
}
