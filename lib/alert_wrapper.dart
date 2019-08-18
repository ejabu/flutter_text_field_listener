import 'package:flutter/material.dart';

class AlertWrapper extends StatefulWidget {
  const AlertWrapper({
    Key key,
  }) : super(key: key);

  @override
  _AlertWrapperState createState() => _AlertWrapperState();
}

class _AlertWrapperState extends State<AlertWrapper> {
  final TextEditingController customRun = TextEditingController();

  changesOnField() {
    print("Updated Text: ${customRun.text}");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    customRun.addListener(changesOnField);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Number'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: customRun,
              decoration: InputDecoration(
                labelText: 'Number',
              ),
            ),
            Text('${customRun.text}'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
