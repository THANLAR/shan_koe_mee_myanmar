import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shan_koe_mee_myanmar/features/public/domain/services/socket_service.dart';

class TcpSocketService implements SocketService {
  Socket? _socket;
  final _controller = StreamController<String>();

  @override
  Future<void> connect(String host, int port) async {
    _socket = await Socket.connect(host, port);
    _socket?.listen((data) {
      _controller.add(utf8.decode(data));
    });
  }

  @override
  Future<void> send(String message) async {
    _socket?.write(message);
  }

  @override
  Stream<String> get onMessage => _controller.stream;

  @override
  void disconnect() {
    _socket?.close();
    _controller.close();
  }
}
