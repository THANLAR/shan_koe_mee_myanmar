import 'dart:io';
import '../core/typedefs.dart';
import 'base_connection.dart';
import '../core/constants.dart';
import '../core/exceptions.dart';

class WebSocketConnection extends BaseConnection {
  HttpServer? _server;
  WebSocket? _client;
  final List<WebSocket> _clients = [];

  @override
  Future<void> startServer({
    required int port,
    required MessageHandler onMessage,
    required DisconnectHandler onDisconnect,
  }) async {
    _server = await HttpServer.bind(InternetAddress.anyIPv4, port);
    _server!.transform(WebSocketTransformer()).listen((WebSocket client) {
      if (_clients.length >= maxRoomSize) {
        client.close();
        throw RoomFullException();
      }
      _clients.add(client);
      client.listen(
        (data) {
          onMessage(data, client.hashCode.toString());
        },
        onDone: () {
          _clients.remove(client);
          onDisconnect(client.hashCode.toString());
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
    _client = await WebSocket.connect('ws://$host:$port');
    _client!.listen((data) {
      onMessage(data, host);
    });
  }

  @override
  Future<void> sendMessage(String message) async {
    _client?.add(message);
  }

  @override
  Future<void> disconnect() async {
    await _client?.close();
    await _server?.close(force: true);
  }
}
