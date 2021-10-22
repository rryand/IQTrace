import 'package:iq_trace/models/timelog.dart';
import 'package:iq_trace/networking/api_base_helper.dart';

class RoomRepository {
  final _api = ApiBaseHelper();

  Future<List<Timelog>> getRoomTimelogs() {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        return [
          Timelog(
            email: 'ramsesryandineros@gmail.com',
            name: 'Ramses Ryan Dineros',
            roomId: 1,
            timestamp: DateTime.now(),
          ),
        ];
      }
    );
  }

  Future<Map<int, List<Timelog>>> getAllTimelogs() async {
    final Map<String, dynamic> response = await _api.get('/timelog/all');

    final Map<int, List<Timelog>> result = {};
    response.forEach((roomNum, roomTimelogs) {
      final resultRoomTimelogs = <Timelog>[];
      final data = new List<dynamic>.from(roomTimelogs);

      if (data.length > 0) {
        data.forEach((timelog) {
          resultRoomTimelogs.add(Timelog.fromJson(timelog));
        });
      }

      result[int.parse(roomNum)] = resultRoomTimelogs;
    });

    return result;
  }

  Future<void> addTimelog(Map<String, dynamic> timelog) async {
    await _api.post('/timelog', timelog);
  }
}
