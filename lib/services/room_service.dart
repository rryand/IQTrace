import 'package:iq_trace/models/timelog.dart';
import 'package:iq_trace/networking/api_response.dart';
import 'package:iq_trace/services/room_repository.dart';

class RoomService {
  final _roomRepo = RoomRepository();

  Future<ApiResponse<Map<int, List<Timelog>>>> getAllTimelogs() async {
    try {
      final Map<int, List<Timelog>> timelogs = await _roomRepo.getAllTimelogs();
      return ApiResponse.completed(timelogs);
    } catch (e) {
      print(e);
      return ApiResponse.error(e.toString());
    }
  }
}
