import 'package:flutter/material.dart';

void main() {
  runApp(SettingsApp());
}

class SettingsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('Notification Settings'),
              trailing: Switch(
                value: false, // You can set the initial value here
                onChanged: (newValue) {
                  // Handle switch state changes
                },
              ),
            ),
            ListTile(
              title: Text('Dark Mode'),
              trailing: Switch(
                value: false, // You can set the initial value here
                onChanged: (newValue) {
                  // Handle switch state changes
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('Change Password'),
              onTap: () {
                // Handle tap
              },
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: () {
                // Handle tap
              },
            ),
          ],
        ),
      ),
    );
  }
}
