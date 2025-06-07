// Entity representing connection information
class ConnectionInfo {
  final String address;
  final int port;
  final bool isWebSocket;

  ConnectionInfo({
    required this.address,
    required this.port,
    required this.isWebSocket,
  });
}
