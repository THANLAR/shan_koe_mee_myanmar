import '../core/enums.dart';
import '../core/typedefs.dart';
import '../network/base_connection.dart';
import '../network/tcp_connection.dart';
import '../network/websocket_connection.dart';

class RoomClient {
  final BaseConnection _connection;

  RoomClient._(this._connection);

  factory RoomClient.connect(NetworkType type) {
    switch (type) {
      case NetworkType.lan:
        return RoomClient._(TcpConnection());
      case NetworkType.internet:
        return RoomClient._(WebSocketConnection());
    }
  }

  Future<void> connect({
    required String host,
    required int port,
    required MessageHandler onMessage,
  }) async {
    await _connection.connectToServer(
      host: host,
      port: port,
      onMessage: onMessage,
    );
  }

  Future<void> send(String message) => _connection.sendMessage(message);

  Future<void> disconnect() => _connection.disconnect();
}
