typedef RoomID = String;
typedef ClientID = String;
typedef MessageHandler = void Function(String message, ClientID from);
typedef DisconnectHandler = void Function(ClientID clientId);
