import 'package:equatable/equatable.dart';

abstract class RoomState extends Equatable {
  const RoomState();
  @override
  List<Object?> get props => [];
}

class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

class RoomConnected extends RoomState {
  final List<String> clients;
  final List<String> messages;
  const RoomConnected(this.clients, this.messages);
  @override
  List<Object?> get props => [clients, messages];
}

class RoomError extends RoomState {
  final String message;
  const RoomError(this.message);
  @override
  List<Object?> get props => [message];
}
