import 'package:shan_koe_mee_myanmar/features/public/domain/repositories/socket_repository.dart';

class JoinRoom {
  final SocketRepository repo;
  JoinRoom(this.repo);

  Future<void> call(String host, int port) => repo.joinRoom(host, port);
}
