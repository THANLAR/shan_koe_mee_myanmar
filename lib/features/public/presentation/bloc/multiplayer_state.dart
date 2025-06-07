import 'package:equatable/equatable.dart';

abstract class MultiplayerState extends Equatable {
  const MultiplayerState();

  @override
  List<Object?> get props => [];
}

class MultiplayerInitial extends MultiplayerState {}

class Connecting extends MultiplayerState {}

class Connected extends MultiplayerState {}

class MessageReceived extends MultiplayerState {
  final String message;

  const MessageReceived(this.message);

  @override
  List<Object?> get props => [message];
}

class MessageSent extends MultiplayerState {}

class Disconnected extends MultiplayerState {}

class MultiplayerError extends MultiplayerState {
  final String message;

  const MultiplayerError(this.message);

  @override
  List<Object?> get props => [message];
}

class MultiplayerLoading extends MultiplayerState {}

class MultiplayerConnected extends MultiplayerState {
  final String roomId;
  final bool isHost;

  const MultiplayerConnected({required this.roomId, required this.isHost});

  @override
  List<Object> get props => [roomId, isHost];
}
