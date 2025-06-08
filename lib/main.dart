import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shan_koe_mee_myanmar/core/di/injector.dart';
import 'package:shan_koe_mee_myanmar/core/utils/super_print.dart';
import 'package:shan_koe_mee_myanmar/features/public/presentation/bloc/multiplayer_bloc.dart';
import 'package:shan_koe_mee_myanmar/features/room/presentation/bloc/room_bloc.dart';
import 'package:shan_koe_mee_myanmar/features/room/presentation/pages/room_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint = (String? message, {int? wrapWidth}) {
    if (message != null && !message.contains('hiddenapi')) {
      superPrint(message);
    }
  };
  await setupDependencies(useWebSocket: false);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<MultiplayerBloc>()),
        BlocProvider(create: (context) => getIt<RoomBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const RoomHomePage(),
      ),
    );
  }
}
