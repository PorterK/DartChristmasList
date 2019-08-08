import 'package:christmas_list/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddUser extends StatefulWidget {
  AddUser({Key key}) : super(key: key);

  @override
  _AddUserState createState() =>
    new _AddUserState();
}

class _AddUserState extends State<StatefulWidget> {
  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();

  String firstName = '';
  String lastName = '';

  final double _textFieldWidth = 200.0;

  @override
  void dispose() {
    super.dispose();

    firstNameNode.dispose();
    lastNameNode.dispose();
  }
  
  @override
  void initState() {
    super.initState();

    firstNameNode.addListener(_onFocusNodeEvent);
    lastNameNode.addListener(_onFocusNodeEvent);
  }

  _onFocusNodeEvent() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Add New Person'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: _textFieldWidth,
              margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: TextField(
                focusNode: firstNameNode,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: firstNameNode.hasFocus ? AppTheme.secondary : Colors.black54),
                  hintText: 'John',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.secondary,
                    ),
                  ),
                ),
                cursorColor: AppTheme.secondary,
              ),
            ),
            Container(
              width: _textFieldWidth,
              margin: EdgeInsets.only(top: 10.0),
              child: TextField(
                focusNode: lastNameNode,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: lastNameNode.hasFocus ? AppTheme.secondary : Colors.black54),
                  hintText: 'Smith',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.secondary,
                    ),
                  ),
                ),
                cursorColor: AppTheme.secondary,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 100.0),
              child: FlatButton(
                onPressed: () => {},
                textColor: Colors.white,
                color: AppTheme.secondary[500],
                padding: EdgeInsets.all(10.0),
                child: Text('Add'),
              )
            )
          ],
        ),
      ),
    );
  }
}