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

  Future<Map<int, List<Timelog>>> getAllTimelogs() {
    return Future.delayed(
      const Duration(seconds: 5),
      () {
        return {
          1: [
            Timelog(
              email: 'ramsesryandineros@gmail.com',
              name: 'Ramses Ryan Dineros',
              roomId: 1,
              timestamp: DateTime.now(),
            ),
            Timelog(
              email: 'russelldineros@gmail.com',
              name: 'Russell Dineros',
              roomId: 1,
              timestamp: DateTime.now(),
            ),
          ],
          2: [
            Timelog(
              email: 'ramsesryandineros@gmail.com',
              name: 'Ramses Ryan Dineros',
              roomId: 2,
              timestamp: DateTime.now(),
            ),
            Timelog(
              email: 'russelldineros@gmail.com',
              name: 'Russell Dineros',
              roomId: 2,
              timestamp: DateTime.now(),
            ),
          ]
        };
      }
    );
  }

  Future<void> addTimelog(Map<String, dynamic> timelog) async {
    await _api.post('/timelog', timelog);
  }
}
