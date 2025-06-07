abstract class SocketRepository {
  Future<void> createRoom(int port);
  Future<void> joinRoom(String host, int port);
}
