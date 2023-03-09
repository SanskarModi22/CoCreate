import 'package:socket_io_client/socket_io_client.dart' as io;

import '../constants/host_service.dart';

class SocketClient {
  io.Socket? socket;
  static SocketClient? _instance;
  SocketClient._internal() {
    socket = io.io(host, <String, dynamic>{
      'transports': ['websocket'],
      'autoconnect': false,
    });
    socket!.connect();
  }
  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
