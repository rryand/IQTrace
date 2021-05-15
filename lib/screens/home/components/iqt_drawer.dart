import 'package:flutter/material.dart';

import 'package:iq_trace/constants.dart';

class IQTDrawer extends StatelessWidget {
  IQTDrawer(this.user);

  final user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildDrawerHeader(),
          ListTile(
            leading: Icon(Icons.check_box),
            title: Text('Update Symptoms'),
            onTap: () => Navigator.pushNamed(context, '/update'),
          ),
          ListTile(
            leading: Icon(Icons.qr_code_scanner),
            title: Text('QR Scanner'),
            onTap: () {},
          ),
          if (user.isAdmin) ...[
            Divider(
              indent: 24.0,
              endIndent: 24.0,
              height: 1.0,
              thickness: 1.0,
            ),
            ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title: Text('Admin'),
              onTap: () {},
            ),
          ],
        ],
      ),
    );
  }

  DrawerHeader _buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(color: iqtPrimaryColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/iqt-icon-black-handle.png',
            height: 65,
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Hello,\n',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  TextSpan(
                    text: user.firstName,
                    style: TextStyle(
                      color: iqtSecondaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}