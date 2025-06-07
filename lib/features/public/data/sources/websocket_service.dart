import 'dart:async';
import 'dart:io';

import 'package:shan_koe_mee_myanmar/features/public/domain/services/socket_service.dart';

class WebSocketService implements SocketService {
  WebSocket? _webSocket;
  final _controller = StreamController<String>();

  @override
  Future<void> connect(String host, int port) async {
    final url = 'ws://$host:$port';
    _webSocket = await WebSocket.connect(url);
    _webSocket?.listen((data) {
      _controller.add(data);
    });
  }

  @override
  Future<void> send(String message) async {
    _webSocket?.add(message);
  }

  @override
  Stream<String> get onMessage => _controller.stream;

  @override
  void disconnect() {
    _webSocket?.close();
    _controller.close();
  }
}
