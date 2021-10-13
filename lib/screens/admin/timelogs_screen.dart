import 'package:flutter/material.dart';
import 'package:iq_trace/models/timelog.dart';
import 'package:iq_trace/networking/api_response.dart';
import 'package:iq_trace/screens/error/error_screen.dart';
import 'package:iq_trace/services/room_service.dart';

class TimelogsScreen extends StatefulWidget {
  const TimelogsScreen({ Key? key }) : super(key: key);

  @override
  _TimelogsScreenState createState() => _TimelogsScreenState();
}

class _TimelogsScreenState extends State<TimelogsScreen> {
  final _roomService = RoomService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResponse<Map<int, List<Timelog>>>>(
      future: _getAllTimelogs(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
          switch (snapshot.data!.status) {
            case Status.COMPLETED:
              return _buildScreen(snapshot.data!.data!);
            case Status.ERROR:
              return ErrorScreen(
                errorMessage: snapshot.data!.message!,
                onRetryPressed: () => Navigator.pop(context),
              );
            case Status.LOADING:
              break;
          }
        } else {
          return Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        throw 'Unhandled null return';
      },
    );
  }

  Widget _buildScreen(Map<int, List<Timelog>> rooms) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timelogs'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: _buildTimelogsTables(rooms)
        ),
      ),
    );
  }

  List<Widget> _buildTimelogsTables(Map<int, List<Timelog>> rooms) {
    final widgets = <Widget>[];
    rooms.forEach((roomId, timelogs) {
      widgets.add(Padding(padding: EdgeInsets.only(top: 8.0)));
      widgets.add(Text('Room: $roomId', style: TextStyle(fontWeight: FontWeight.bold)));
      widgets.add(
        Table(
          border: TableBorder.all(),
          children: <TableRow>[
            TableRow(
              children: <Text>[
                Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Timelog', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            ..._buildRows(timelogs)
          ],
        )
      );
    });

    return widgets;
  }

  List<TableRow> _buildRows(List<Timelog> timelogs) {
    final rows = <TableRow>[];
    timelogs.forEach((timelog) {
      rows.add(
        TableRow(
          children: <Text>[
            Text(timelog.name),
            Text(timelog.email),
            Text(timelog.timestamp.toString())
          ]
        )
      );
    });

    return rows;
  }

  Future<ApiResponse<Map<int, List<Timelog>>>> _getAllTimelogs() async {
    return await _roomService.getAllTimelogs();
  }
}