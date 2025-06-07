import 'package:equatable/equatable.dart';

abstract class MultiplayerEvent extends Equatable {
  const MultiplayerEvent();

  @override
  List<Object?> get props => [];
}

class ConnectToRoom extends MultiplayerEvent {
  final String host;
  final int port;

  const ConnectToRoom({required this.host, required this.port});

  @override
  List<Object?> get props => [host, port];
}

class DisconnectFromRoom extends MultiplayerEvent {}

class SendMessage extends MultiplayerEvent {
  final String message;

  const SendMessage(this.message);

  @override
  List<Object?> get props => [message];
}

class ReceiveMessage extends MultiplayerEvent {
  final String message;

  const ReceiveMessage(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateRoomEvent extends MultiplayerEvent {
  final String roomId;

  const CreateRoomEvent(this.roomId);

  @override
  List<Object> get props => [roomId];
}

class JoinRoomEvent extends MultiplayerEvent {
  final String roomId;

  const JoinRoomEvent(this.roomId);

  @override
  List<Object> get props => [roomId];
}

class StartGameEvent extends MultiplayerEvent {}
