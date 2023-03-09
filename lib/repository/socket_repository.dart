import 'package:socket_io_client/socket_io_client.dart';
import '../client/socket_client.dart';

class SocketRepo {
  final _socketClient = SocketClient.instance.socket!;
  Socket get socketClient => _socketClient;

  void joinRoom(String documentID) {
    _socketClient.emit('join', documentID);
  }
}
