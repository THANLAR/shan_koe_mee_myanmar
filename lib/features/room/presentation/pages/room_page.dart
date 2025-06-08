import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shan_koe_mee_myanmar/core/utils/super_print.dart';
import '../bloc/room_bloc.dart';
import '../bloc/room_state.dart';
import '../bloc/room_event.dart';

class RoomPage extends StatefulWidget {
  final bool isHost;
  const RoomPage({super.key, required this.isHost});
  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage>
    with SingleTickerProviderStateMixin {
  final _msgController = TextEditingController();
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animController.dispose();
    _msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomBloc, RoomState>(
      listener: (context, state) {
        if (state is RoomError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        superPrint('RoomPage rebuild: ${state.runtimeType}');
        if (state is RoomLoading) {
          return Scaffold(
            body: Center(
              child: ScaleTransition(
                scale: Tween(begin: 1.0, end: 1.2).animate(
                  CurvedAnimation(
                    parent: _animController,
                    curve: Curves.easeInOut,
                  ),
                ),
                child: const CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (state is RoomConnected) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.isHost ? 'Room (Host)' : 'Room (Client)'),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text('${state.clients.length}/10'),
                    backgroundColor: Colors.green[100],
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.people, color: Colors.green),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          children: state.clients
                              .map(
                                (c) => Chip(
                                  label: Text(c),
                                  backgroundColor: Colors.green[200],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.messages.length,
                    itemBuilder: (_, i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: i % 2 == 0 ? Colors.white : Colors.green[100],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Text(state.messages[i]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _msgController,
                          decoration: const InputDecoration(
                            hintText: 'Type a message...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (_msgController.text.trim().isNotEmpty) {
                            context.read<RoomBloc>().add(
                              SendMessage(_msgController.text.trim()),
                            );
                            _msgController.clear();
                          }
                        },
                        child: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const Scaffold(
          body: Center(child: Text('Welcome to the Room!')),
        );
      },
    );
  }
}
