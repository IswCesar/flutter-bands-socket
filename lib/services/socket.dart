import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class Socket with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  Socket() {
    this._initconfig();
  }

  void _initconfig() {
    // 1 Dart client
    this._socket = IO.io('http://10.0.2.2:3000', {
      'transports': ['websocket'],
      'autoConnect': true
    });

    this._socket.on('connect', (_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    /*
    socket.on('new-message', (payload) {
      print('new-message:');
      print(payload.containsKey('name')
          ? 'Name:' + payload['name']
          : 'No existe');
      print(payload.containsKey('age') ? 'Age:' + payload['age'] : 'No existe');
    });*/
  }
}
