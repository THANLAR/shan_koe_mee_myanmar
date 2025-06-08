class RoomFullException implements Exception {
  final String message;
  RoomFullException([this.message = 'Room is full']);
  @override
  String toString() => message;
}
