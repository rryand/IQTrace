class Timelog {
  final String email;
  final String name;
  final int roomId;
  final DateTime timestamp;

  Timelog({
    required this.email,
    required this.name,
    required this.roomId,
    required this.timestamp
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'room_id': roomId,
    'timestamp': timestamp,
  };

  factory Timelog.fromJson(Map<String, dynamic> timelog) {
    return Timelog(
      email: timelog['email'],
      name: timelog['name'],
      roomId: timelog['room_id'],
      timestamp: timelog['timestamp'],
    );
  }
}