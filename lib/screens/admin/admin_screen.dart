import 'package:flutter/material.dart';
import 'package:iq_trace/models/user.dart';
import 'package:iq_trace/networking/api_response.dart';
import 'package:iq_trace/screens/admin/components/active_symptom_list.dart';
import 'package:iq_trace/screens/admin/timelogs_screen.dart';
import 'package:iq_trace/screens/error/error_screen.dart';
import 'package:iq_trace/services/user_service.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({ Key? key }) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<User>? usersWithSymptoms;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
      ),
      body: FutureBuilder<ApiResponse<List<User>?>>(
        future: _getActiveSymptoms(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data!.status) {
              case Status.COMPLETED:
                return _buildBody();
              case Status.ERROR:
                return ErrorScreen(
                  errorMessage: snapshot.data!.message!,
                  onRetryPressed: () => Navigator.pop(context),
                );
              default:
                break;
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
          throw 'Is not complete';
        },
      ),
    );
  }

  Future<ApiResponse<List<User>?>> _getActiveSymptoms() async {
    // TODO: get active symptoms from user repo
    try {
      usersWithSymptoms = await UserService.instance.getUsersWithActiveSymptoms();
      return ApiResponse.completed(usersWithSymptoms);
    } catch (e) {
      print(e);
      return ApiResponse.error(e.toString());
    }
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        ActiveSymptomList(usersWithSymptoms: usersWithSymptoms),
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TimelogsScreen(),
                )
              );
            },
            child: Text('Timelogs'),
          ),
        )
      ],
    );
  }
}
