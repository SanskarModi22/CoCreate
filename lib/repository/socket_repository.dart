import 'package:socket_io_client/socket_io_client.dart';
import '../client/socket_client.dart';

class SocketRepo {
  final _socketClient = SocketClient.instance.socket!;
  Socket get socketClient => _socketClient;

  void joinRoom(String documentID) {
    _socketClient.emit('join', documentID);
  }

  void typing(Map<String?, dynamic> data) {
    _socketClient.emit('typing', data);
  }

  void autoSave(Map<String?, dynamic> data) {
    _socketClient.emit('save', data);
  }

  void changeListener(Function(Map<String?, dynamic>) func) {
    _socketClient.on('changes', (data) => func(data));
  }
}
