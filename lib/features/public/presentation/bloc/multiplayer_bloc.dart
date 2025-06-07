export 'multiplayer_event.dart';
export 'multiplayer_state.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shan_koe_mee_myanmar/features/public/domain/services/socket_service.dart';
import 'multiplayer_event.dart';
import 'multiplayer_state.dart';

class MultiplayerBloc extends Bloc<MultiplayerEvent, MultiplayerState> {
  final SocketService socketService;
  StreamSubscription<String>? _messageSub;

  MultiplayerBloc(this.socketService) : super(MultiplayerInitial()) {
    on<ConnectToRoom>(_onConnectToRoom);
    on<SendMessage>(_onSendMessage);
    on<ReceiveMessage>(_onReceiveMessage);
    on<DisconnectFromRoom>(_onDisconnect);
  }

  Future<void> _onConnectToRoom(
    ConnectToRoom event,
    Emitter<MultiplayerState> emit,
  ) async {
    emit(Connecting());
    try {
      await socketService.connect(event.host, event.port);

      _messageSub?.cancel();
      _messageSub = socketService.onMessage.listen((msg) {
        add(ReceiveMessage(msg));
      });

      emit(Connected());
    } catch (e) {
      emit(MultiplayerError("Connection failed: ${e.toString()}"));
    }
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<MultiplayerState> emit,
  ) async {
    try {
      await socketService.send(event.message);
      emit(MessageSent());
    } catch (e) {
      emit(MultiplayerError("Failed to send: ${e.toString()}"));
    }
  }

  void _onReceiveMessage(ReceiveMessage event, Emitter<MultiplayerState> emit) {
    emit(MessageReceived(event.message));
  }

  Future<void> _onDisconnect(
    DisconnectFromRoom event,
    Emitter<MultiplayerState> emit,
  ) async {
    socketService.disconnect();
    await _messageSub?.cancel();
    emit(Disconnected());
  }

  @override
  Future<void> close() {
    _messageSub?.cancel();
    socketService.disconnect();
    return super.close();
  }
}
