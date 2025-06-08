import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shan_koe_mee_myanmar/core/utils/super_print.dart';
import '../../../../room/room_manager.dart';
import '../../../../room/room_client.dart';
import 'room_event.dart';
import 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomManager? _manager;
  RoomClient? _client;
  final List<String> _clients = [];
  final List<String> _messages = [];

  RoomBloc() : super(RoomInitial()) {
    on<CreateRoom>((event, emit) async {
      emit(RoomLoading());
      _manager = RoomManager.create(event.type);
      try {
        await _manager!.startRoom(
          port: event.port,
          onMessage: (msg, from) {
            _messages.add('$from: $msg');
            if (!_clients.contains(from)) _clients.add(from);
            add(SendMessage(''));
          },
          onDisconnect: (id) {
            _clients.remove(id);
            add(SendMessage(''));
          },
        );
        emit(RoomConnected(List.from(_clients), List.from(_messages)));
      } catch (e) {
        emit(RoomError(e.toString()));
      }
    });

    on<JoinRoom>((event, emit) async {
      emit(RoomLoading());
      _client = RoomClient.connect(event.type);
      try {
        superPrint('Connected to room at ${event.host}:${event.port}');
        _client?.connect(
          host: event.host,
          port: event.port,
          onMessage: (msg, from) {
            _messages.add('$from: $msg');
            add(SendMessage(''));
          },
        );
        superPrint('Connected to room at ${event.host}:${event.port}');
        emit(RoomConnected(List.from(_clients), List.from(_messages)));
      } catch (e) {
        emit(RoomError(e.toString()));
      }
    });

    on<SendMessage>((event, emit) async {
      if (event.message.isNotEmpty) {
        await _client?.send(event.message);
        _messages.add('Me: ${event.message}');
      }
      emit(RoomConnected(List.from(_clients), List.from(_messages)));
    });
  }
}
