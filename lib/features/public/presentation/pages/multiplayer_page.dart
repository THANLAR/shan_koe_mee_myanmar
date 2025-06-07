import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shan_koe_mee_myanmar/features/public/presentation/bloc/multiplayer_bloc.dart';

class MultiplayerPage extends StatefulWidget {
  const MultiplayerPage({super.key});

  @override
  State<MultiplayerPage> createState() => _MultiplayerPageState();
}

class _MultiplayerPageState extends State<MultiplayerPage> {
  final TextEditingController _roomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MultiplayerBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Multiplayer Room')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<MultiplayerBloc, MultiplayerState>(
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  controller: _roomController,
                  decoration: const InputDecoration(
                    labelText: 'Room ID',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final roomId = _roomController.text.trim();
                          if (roomId.isNotEmpty) {
                            bloc.add(CreateRoomEvent(roomId));
                          }
                        },
                        child: const Text('Create Room'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final roomId = _roomController.text.trim();
                          if (roomId.isNotEmpty) {
                            bloc.add(JoinRoomEvent(roomId));
                          }
                        },
                        child: const Text('Join Room'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (state is MultiplayerError)
                  Text(state.message, style: TextStyle(color: Colors.red)),
                if (state is MultiplayerConnected)
                  ElevatedButton(
                    onPressed: () {
                      bloc.add(StartGameEvent());
                    },
                    child: const Text('Start Game'),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _roomController.dispose();
    super.dispose();
  }
}
