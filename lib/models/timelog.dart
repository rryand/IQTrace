import 'package:iq_trace/services/helpers/date_helper.dart';

class Timelog {
  final String email;
  final String? name;
  final int roomId;
  final DateTime timestamp;

  Timelog({
    required this.email,
    this.name,
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
      email: timelog['user_email'],
      roomId: timelog['room_number'],
      timestamp: DateHelper.fromString(timelog['timestamp']),
    );
  }
}