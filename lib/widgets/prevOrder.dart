import 'package:flutter/material.dart';
import '../models/previousOrder.dart';
import '../services/api_service.dart';
import 'package:intl/intl.dart';

class PrevOrder extends StatelessWidget {
  ApiService api = ApiService();

  ListView _jobsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(data[index].refNo, data[index].total, Icons.receipt,
              data[index].createdAt);
        });
  }

  ListTile _tile(String refNo, String total, IconData icon, date) => ListTile(
        title: Text(refNo,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text('£$total'),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
        trailing: Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(date))),
      );

  Future<List<PreviousOrder>> _fetchJobs() async {
    ApiService api = ApiService();
    return api.userOrders();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PreviousOrder>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<PreviousOrder> data = snapshot.data;
          return data.length > 0
              ? _jobsListView(data)
              : Container(
                  child: Center(
                    child: Text("No order yet",
                        style: TextStyle(fontSize: 19.0, color: Colors.grey)),
                  ),
                );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
