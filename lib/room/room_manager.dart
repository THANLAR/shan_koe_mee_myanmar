import '../core/enums.dart';
import '../core/typedefs.dart';
import '../network/base_connection.dart';
import '../network/tcp_connection.dart';
import '../network/websocket_connection.dart';

class RoomManager {
  final BaseConnection _connection;
  final List<ClientID> _connectedClients = [];

  RoomManager._(this._connection);

  factory RoomManager.create(NetworkType type) {
    switch (type) {
      case NetworkType.lan:
        return RoomManager._(TcpConnection());
      case NetworkType.internet:
        return RoomManager._(WebSocketConnection());
    }
  }

  Future<void> startRoom({
    required int port,
    required MessageHandler onMessage,
    required DisconnectHandler onDisconnect,
  }) async {
    await _connection.startServer(
      port: port,
      onMessage: (msg, clientId) {
        if (!_connectedClients.contains(clientId)) {
          _connectedClients.add(clientId);
        }
        onMessage(msg, clientId);
      },
      onDisconnect: (clientId) {
        _connectedClients.remove(clientId);
        onDisconnect(clientId);
      },
    );
  }

  Future<void> stopRoom() => _connection.disconnect();
}
