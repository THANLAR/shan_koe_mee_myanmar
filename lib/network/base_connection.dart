import '../core/typedefs.dart';

abstract class BaseConnection {
  Future<void> startServer({
    required int port,
    required MessageHandler onMessage,
    required DisconnectHandler onDisconnect,
  });

  Future<void> connectToServer({
    required String host,
    required int port,
    required MessageHandler onMessage,
  });

  Future<void> sendMessage(String message);

  Future<void> disconnect();
}
