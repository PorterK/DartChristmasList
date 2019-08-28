import 'package:christmas_list/constants/theme.dart';
import 'package:christmas_list/lib/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddPerson extends StatefulWidget {
  final Function addPerson;

  AddPerson({Key key, @required this.addPerson}) : super(key: key);

  @override
  _AddPersonState createState() => _AddPersonState(addPerson: addPerson);
}

class _AddPersonState extends State<StatefulWidget> {
  Function addPerson;

  _AddPersonState({ @required this.addPerson});

  List<String> textFields = [
    'name',
    'shirtSize',
    'pantsSize',
    'shoeSize'
  ];

  Map nodes = new Map();

  Person person = new Person();

  String activeField;

  final double _textFieldWidth = 200.0;

  @override
  void dispose() {
    super.dispose();

    nodes.forEach((key, val) {
      if (val != null) val.dispose();
    });
  }
  
  @override
  void initState() {
    super.initState();

    textFields.forEach((field) {
      nodes[field] = FocusNode();
    });

    nodes.forEach((key, val) {
      val.addListener(() {
        activeField = key;
      });
    });
  }

  void _changeName(String val) { setState(() { person.name = val; }); }
  void _changeShirtSize(String val) { setState(() { person.shirtSize = val; }); }
  void _changePantsSize(String val) { setState(() { person.pantsSize = val; }); }
  void _changeShoeSize(String val) { setState(() { person.shoeSize = val; }); }

  _onPressedEvent() {
    this.addPerson(person);

    Navigator.pop(context);
  }

  _nextField(_) {
    print(activeField);

    print('clicked');

    print('Next text field: ${textFields[textFields.indexOf(activeField) + 1]}');

    String nextFieldName = textFields[textFields.indexOf(activeField) + 1];

    nodes[activeField].unfocus();

    setState(() {
      FocusScope.of(context).requestFocus(nodes[nextFieldName]);
    });
  }

  _hideKeyboard(_) {
    setState(() {
      FocusScope.of(context).requestFocus(new FocusNode());
    });
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
                autofocus: true,
                textInputAction: TextInputAction.done,
                focusNode: nodes['name'],
                onSubmitted: _nextField,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: nodes['name'].hasFocus ? AppTheme.secondary : Colors.black54),
                  hintText: 'Jane Smith',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.secondary,
                    ),
                  ),
                ),
                cursorColor: AppTheme.secondary,
                onChanged: _changeName,
              ),
            ),
            Container(
              width: _textFieldWidth,
              margin: EdgeInsets.only(top: 10.0),
              child: TextField(
                textInputAction: TextInputAction.done,
                focusNode: nodes['shirtSize'],
                onSubmitted: _nextField,
                decoration: InputDecoration(
                  labelText: 'Shirt Size',
                  labelStyle: TextStyle(color: nodes['shirtSize'].hasFocus ? AppTheme.secondary : Colors.black54),
                  hintText: 'Medium',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.secondary,
                    ),
                  ),
                ),
                cursorColor: AppTheme.secondary,
                onChanged: _changeShirtSize,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: _textFieldWidth / 2 - 5,
                  margin: EdgeInsets.only(top: 10.0, right: 10.0),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    focusNode: nodes['pantsSize'],
                    onSubmitted: _nextField,
                    decoration: InputDecoration(
                      labelText: 'Pants Size',
                      labelStyle: TextStyle(color: nodes['pantsSize'].hasFocus ? AppTheme.secondary : Colors.black54),
                      hintText: '32 / 28',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.secondary,
                        ),
                      ),
                    ),
                    cursorColor: AppTheme.secondary,
                    onChanged: _changePantsSize,
                  ),
                ),
                Container(
                  width: _textFieldWidth / 2 - 5,
                  margin: EdgeInsets.only(top: 10.0),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    focusNode: nodes['shoeSize'],
                    onSubmitted: _hideKeyboard,
                    decoration: InputDecoration(
                      labelText: 'Shoe Size',
                      labelStyle: TextStyle(color: nodes['shoeSize'].hasFocus ? AppTheme.secondary : Colors.black54),
                      hintText: '10',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.secondary,
                        ),
                      ),
                    ),
                    cursorColor: AppTheme.secondary,
                    onChanged: _changeShoeSize,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 100.0),
              child: FlatButton(
                onPressed: _onPressedEvent,
                textColor: Colors.white,
                color: AppTheme.secondary[500],
                padding: EdgeInsets.all(10.0),
                child: Text('Save Person'),
              )
            )
          ],
        ),
      ),
    );
  }
}