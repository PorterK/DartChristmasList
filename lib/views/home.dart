import 'package:flutter/material.dart';

import 'package:christmas_list/constants/theme.dart';
import 'package:christmas_list/lib/person.dart';

import 'add_user.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Person> _people = [];

  void _openAddUser() {
    Navigator.push(context, MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return AddUser(addPerson: _addPerson);
      },
      fullscreenDialog: true,
    ));
  }

  void _addPerson(Person person) {
    setState(() {
      _people.add(person);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: _people.length > 0 ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8.0),
              itemCount: _people.length,
              itemBuilder: (BuildContext context, int index) {
                Person person = _people[index];
                return Card(
                  child: ListTile(
                    title: Text(person.name),
                    trailing: Icon(Icons.edit),
                    subtitle: Text("${person.gifts.length} gifts, ${person.wishes.length} items in wish list"),
                  ),
                );
              },
            ),
            FlatButton(
              onPressed: _openAddUser,
              textColor: Colors.white,
              color: AppTheme.secondary[500],
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Icon(Icons.add),
                  Text('Add Person')
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Scan Barcode or Take Picture',
        child: Icon(Icons.photo_camera),
      ),
    );
  }
}