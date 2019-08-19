import 'package:christmas_list/constants/theme.dart';
import 'package:christmas_list/lib/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddUser extends StatefulWidget {
  final Function addPerson;

  AddUser({Key key, @required this.addPerson}) : super(key: key);

  @override
  _AddUserState createState() =>
    new _AddUserState(addPerson: addPerson);
}

class _AddUserState extends State<StatefulWidget> {
  Function addPerson;

  _AddUserState({ @required this.addPerson });
  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();

  Person person = new Person();

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

  void _changeFirstName(String val) { setState(() { person.firstName = val; }); }
  void _changeLastName(String val) { setState(() { person.lastName = val; }); }

  _onFocusNodeEvent() {
    setState(() {});
  }

  _onPressedEvent() {
    this.addPerson(person);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onChanged: _changeFirstName,
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
                onChanged: _changeLastName,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 100.0),
              child: FlatButton(
                onPressed: _onPressedEvent,
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