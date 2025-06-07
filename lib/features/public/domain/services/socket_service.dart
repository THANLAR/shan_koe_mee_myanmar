abstract class SocketService {
  Future<void> connect(String host, int port);
  Future<void> send(String message);
  Stream<String> get onMessage;
  void disconnect();
}
