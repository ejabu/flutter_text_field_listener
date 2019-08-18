# Text Field Listener

Rebuild Text widget as we type on Text Field widget

For demo, you may look here. [Example](#demo)


## 1. Identify Text widget that needs rebuild

First we expect content inside this widget to be rebuild as user types.


``` dart
Text('${customRun.text}'),
```

Unfortunately, this widget resides inside widePopUpCustom method as 
Alert Dialog children

``` dart
void widePopUpCustom() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
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
                Text('${customRun.text}'), // Needs to be re-rendered
              ],
            ),
          ),
        );
      },
    );
  }
```

in this case, we cannot trigger rebuild on `AlertDialog` widget including all of its childern, `ListBody`, `TextField` and `Text` widget.


## 2. Split `AlertDialog` and convert it to Stateful Widget

We consider moving `AlertDialog` into `AlertWrapper`, and define `AlertWrapper` as **Stateful Widget**. So later, we can trigger rebuild of `AlertWrapper` using this code : 

``` dart
setState((){})
```



We can conclude this step, as modifying `widePopUpCustom()` to this one :

``` dart
Future<void> widePopUpCustom() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertWrapper();
      },
    );
  }
```

> Before, AlertDialog will be considered as Stateless that won't be re-rendered unless we close the dialog.

## 3. Override Stateful Widget to attach listener

By using stateful widget, we can explore initState usage. In this case, we attach `addListener` to `customRun` TextController.

> Please notice changesOnField method. This method will be triggered each time user interacts with keyboard input


``` dart
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
    setState(() {}); // Will re-Trigger Build Method
  }

  @override
  void initState() {
    super.initState();
    customRun.addListener(changesOnField);
  }
}
```


changesOnField will trigger build method to be re-called, and then we can our value inside Text widget updated

``` dart
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
            Text('${customRun.text}'), // Finally re-rendered
          ],
        ),
      ),
```


## Demo
![Demo](demo.gif)
