import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:shan_koe_mee_myanmar/core/utils/super_print.dart';
import 'package:shan_koe_mee_myanmar/features/public/data/sources/tcp_socket_service.dart';
import 'package:shan_koe_mee_myanmar/features/public/data/sources/websocket_service.dart';
import 'package:shan_koe_mee_myanmar/features/public/domain/services/socket_service.dart';
import 'package:shan_koe_mee_myanmar/features/public/data/repositories/socket_repository_impl.dart';
import 'package:shan_koe_mee_myanmar/features/public/domain/repositories/socket_repository.dart';
import 'package:shan_koe_mee_myanmar/features/public/domain/usecases/create_room.dart';
import 'package:shan_koe_mee_myanmar/features/public/domain/usecases/join_room.dart';
import 'package:shan_koe_mee_myanmar/features/public/presentation/bloc/multiplayer_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shan_koe_mee_myanmar/firebase_options.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies({bool useWebSocket = false}) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await getIt.reset();

  // Register SocketService (TCP or WebSocket)
  getIt.registerLazySingleton<SocketService>(() {
    return useWebSocket ? WebSocketService() : TcpSocketService();
  });

  // Register SocketRepository
  getIt.registerLazySingleton<SocketRepository>(() => SocketRepositoryImpl());

  // Register UseCases
  getIt.registerLazySingleton(() => CreateRoom(getIt<SocketRepository>()));
  getIt.registerLazySingleton(() => JoinRoom(getIt<SocketRepository>()));

  // Register Bloc
  getIt.registerFactory(() => MultiplayerBloc(getIt<SocketService>()));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // You can log or handle the message here.
  superPrint('📩 Background FCM message received: ${message.messageId}');
  superPrint('Data: ${message.data}');
  superPrint(
    'Notification: ${message.notification?.title} - ${message.notification?.body}',
  );

  // You can inject services or handle logic manually if needed
  // e.g., saving to local DB, triggering local notifications, etc.
}
