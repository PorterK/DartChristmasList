import 'package:christmas_list/constants/theme.dart';
import 'package:christmas_list/lib/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditPerson extends StatefulWidget {
  final Function savePerson;
  final Function deletePerson;
  final Map data;

  EditPerson({Key key, @required this.savePerson, @required this.deletePerson, this.data = const {} }) : super(key: key);

  @override
  _EditPersonState createState() =>
    new _EditPersonState(savePerson: savePerson, deletePerson: deletePerson, data: this.data);
}

class _EditPersonState extends State<StatefulWidget> {
  Function savePerson;
  Function deletePerson;
  Map data;

  _EditPersonState({ @required this.savePerson, @required this.deletePerson, this.data,});

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

    person.from(this.data);

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

  _save() {
    this.savePerson(person);

    Navigator.pop(context);
  }

  _delete() {
    this.deletePerson(person);

    Navigator.pop(context);
  }

  _hideKeyboard(_) {
    setState(() {
      FocusScope.of(context).requestFocus(new FocusNode());
    });
  }

  _confirmDelete() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Really delete ${person.name}?"),
          content: Text('This action cannot be undone.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              textColor: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Yes'),
              textColor: Colors.white,
              color: AppTheme.secondary[500],
              onPressed: () {
                _delete();
              },
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit ${person.name}"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: _textFieldWidth,
              margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: TextField(
                textInputAction: TextInputAction.done,
                focusNode: nodes['name'],
                onSubmitted: _hideKeyboard,
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: person.name,
                    selection: TextSelection.collapsed(
                      offset: person.name.length
                    )
                  )
                ),
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
                onSubmitted: _hideKeyboard,
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: person.shirtSize,
                    selection: TextSelection.collapsed(
                      offset: person.shirtSize.length
                    )
                  )
                ),
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
                    onSubmitted: _hideKeyboard,
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: person.pantsSize,
                        selection: TextSelection.collapsed(
                          offset: person.pantsSize.length
                        )
                      )
                    ),
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
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: person.shoeSize,
                        selection: TextSelection.collapsed(
                          offset: person.shoeSize.length
                        )
                      )
                    ),
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
              margin: EdgeInsets.only(top: 100.0, right: ((MediaQuery.of(context).size.width - _textFieldWidth) / 2) - (_textFieldWidth / 4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    onPressed: _save,
                    textColor: Colors.white,
                    color: AppTheme.primary[500],
                    child: Text('Save'),
                  ),
                  ButtonTheme(
                    minWidth: _textFieldWidth / 2,
                    child: FlatButton(
                      textColor: AppTheme.secondary[500],
                      child: Text('Delete'),
                      onPressed: _confirmDelete,
                    ),
                  )
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}