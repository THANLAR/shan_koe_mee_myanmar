import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shan_koe_mee_myanmar/card_shaffel.dart';
import 'package:shan_koe_mee_myanmar/core/di/injector.dart';
import 'package:shan_koe_mee_myanmar/core/utils/super_print.dart';
import 'package:shan_koe_mee_myanmar/features/public/presentation/bloc/multiplayer_bloc.dart';
// import 'package:shan_koe_mee_myanmar/features/multiplayer/presentation/pages/multiplayer_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint = (String? message, {int? wrapWidth}) {
    if (message != null && !message.contains('hiddenapi')) {
      superPrint(message);
    }
  };
  await setupDependencies(useWebSocket: false);
  runApp(const CardStackApp());
}

class CardStackApp extends StatelessWidget {
  const CardStackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => getIt<MultiplayerBloc>(),
        child: const CardShuffleScreen(), //CardShuffleScreen  MultiplayerPage
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
