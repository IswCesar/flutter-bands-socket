import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:band_names/services/socket.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 3 using provider
    final socket = Provider.of<Socket>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('Server status: ${socket.serverStatus}')],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () {
          socket.socket.emit('new-message',
              {"name": "cesar", "message": "Hello from flutter"});
        },
      ),
    );
  }
}
