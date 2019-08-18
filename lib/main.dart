import 'package:flutter/material.dart';

import 'alert_wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<void> widePopUpCustom() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertWrapper();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listen to Text Field Changes"),
      ),
      body: Center(
        child: RaisedButton.icon(
          label: Text("Add Number"),
          icon: Icon(Icons.repeat_one),
          onPressed: () {
            widePopUpCustom();
          },
        ),
      ),
    );
  }
}
