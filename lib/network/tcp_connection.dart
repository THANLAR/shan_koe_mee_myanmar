import 'dart:io';
import '../core/typedefs.dart';
import 'base_connection.dart';
import '../core/constants.dart';
import '../core/exceptions.dart';

class TcpConnection extends BaseConnection {
  ServerSocket? _server;
  Socket? _client;
  final List<Socket> _clients = [];

  @override
  Future<void> startServer({
    required int port,
    required MessageHandler onMessage,
    required DisconnectHandler onDisconnect,
  }) async {
    _server = await ServerSocket.bind(InternetAddress.anyIPv4, port);
    _server!.listen((Socket client) {
      if (_clients.length >= maxRoomSize) {
        client.destroy(); // reject extra clients
        throw RoomFullException();
      }
      _clients.add(client);
      client.listen(
        (data) {
          onMessage(String.fromCharCodes(data), client.remoteAddress.address);
        },
        onDone: () {
          _clients.remove(client);
          onDisconnect(client.remoteAddress.address);
        },
      );
    });
  }

  @override
  Future<void> connectToServer({
    required String host,
    required int port,
    required MessageHandler onMessage,
  }) async {
    _client = await Socket.connect(host, port);
    _client!.listen((data) {
      onMessage(String.fromCharCodes(data), host);
    });
  }

  @override
  Future<void> sendMessage(String message) async {
    _client?.write(message);
  }

  @override
  Future<void> disconnect() async {
    await _client?.close();
    await _server?.close();
  }
}
