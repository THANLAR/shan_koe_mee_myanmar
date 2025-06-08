import 'package:equatable/equatable.dart';
import '../../../../core/enums.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();
  @override
  List<Object?> get props => [];
}

class CreateRoom extends RoomEvent {
  final NetworkType type;
  final int port;
  const CreateRoom(this.type, this.port);
  @override
  List<Object?> get props => [type, port];
}

class JoinRoom extends RoomEvent {
  final NetworkType type;
  final String host;
  final int port;
  const JoinRoom(this.type, this.host, this.port);
  @override
  List<Object?> get props => [type, host, port];
}

class SendMessage extends RoomEvent {
  final String message;
  const SendMessage(this.message);
  @override
  List<Object?> get props => [message];
}
