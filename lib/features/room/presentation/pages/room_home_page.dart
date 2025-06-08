import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/enums.dart';
import '../bloc/room_bloc.dart';
import '../bloc/room_event.dart';
import 'room_page.dart';

class RoomHomePage extends StatefulWidget {
  const RoomHomePage({super.key});
  @override
  State<RoomHomePage> createState() => _RoomHomePageState();
}

class _RoomHomePageState extends State<RoomHomePage> {
  NetworkType _type = NetworkType.lan;
  final _portController = TextEditingController(text: '9000');
  final _hostController = TextEditingController(text: '127.0.0.1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multiplayer Room')),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<NetworkType>(
                value: _type,
                items: NetworkType.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _type = v!),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _portController,
                decoration: const InputDecoration(labelText: 'Port'),
                keyboardType: TextInputType.number,
              ),
              if (_type == NetworkType.internet)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextField(
                    controller: _hostController,
                    decoration: const InputDecoration(labelText: 'Host'),
                  ),
                ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add_box_rounded),
                      label: const Text('Create Room'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) => GetIt.instance<RoomBloc>()
                                ..add(
                                  CreateRoom(
                                    _type,
                                    int.parse(_portController.text),
                                  ),
                                ),
                              child: const RoomPage(isHost: true),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.login_rounded),
                      label: const Text('Join Room'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) => GetIt.instance<RoomBloc>()
                                ..add(
                                  JoinRoom(
                                    _type,
                                    _hostController.text,
                                    int.parse(_portController.text),
                                  ),
                                ),
                              child: const RoomPage(isHost: false),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
