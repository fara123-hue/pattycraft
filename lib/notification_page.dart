import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/notification_model.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifications = Provider.of<NotificationModel>(context).messages;

    return Scaffold(
      appBar: AppBar(title: Text("Notifikasi")),
      body: notifications.isEmpty
          ? Center(child: Text("Belum ada notifikasi"))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) => ListTile(
                leading: Icon(Icons.notifications),
                title: Text(notifications[index]),
              ),
            ),
    );
  }
}
