import 'dart:io';
import '../../domain/repositories/socket_repository.dart';

class SocketRepositoryImpl implements SocketRepository {
  ServerSocket? _server;
  Socket? _client;

  @override
  Future<void> createRoom(int port) async {
    _server = await ServerSocket.bind(InternetAddress.anyIPv4, port);
    _server!.listen((client) {
      _client = client;
      client.listen((data) {});
      client.write('Welcome to the room!');
    });
  }

  @override
  Future<void> joinRoom(String host, int port) async {
    _client = await Socket.connect(host, port);
    _client!.listen((data) {});
    _client!.write('Hello, I joined!');
  }
}
