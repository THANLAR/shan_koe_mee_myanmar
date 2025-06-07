import 'package:shan_koe_mee_myanmar/features/public/domain/repositories/socket_repository.dart';

class CreateRoom {
  final SocketRepository repo;
  CreateRoom(this.repo);

  Future<void> call(int port) => repo.createRoom(port);
}
