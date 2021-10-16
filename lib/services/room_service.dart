import 'package:iq_trace/models/timelog.dart';
import 'package:iq_trace/networking/api_response.dart';
import 'package:iq_trace/services/room_repository.dart';
import 'package:iq_trace/services/user_service.dart';

class RoomService {
  final _roomRepo = RoomRepository();
  final _userService = UserService.instance;

  Future<ApiResponse<Map<int, List<Timelog>>>> getAllTimelogs() async {
    try {
      final Map<int, List<Timelog>> timelogs = await _roomRepo.getAllTimelogs();
      return ApiResponse.completed(timelogs);
    } catch (e) {
      print(e);
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<void>> addTimelog(Map<String, dynamic> timelog) async {
    final user = await _userService.getUser();
    try {
      timelog['user_email'] = user.email!;
      timelog['timestamp'] = DateTime.now().toIso8601String();
      await _roomRepo.addTimelog(timelog);
      return ApiResponse.completed(null);
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return ApiResponse.error(e.toString());
    }
  }
}
