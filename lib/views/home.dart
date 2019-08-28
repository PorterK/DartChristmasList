import 'package:flutter/material.dart';

import 'package:christmas_list/constants/theme.dart';
import 'package:christmas_list/lib/person.dart';

import 'add_person.dart';
import 'edit_person.dart';
import 'qr_scanner.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Person> _people = [];

  void _openQRScanner() {
    Navigator.push(context, MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return QrScanner();
      }
    ));
  }

  void _openAddPerson() {
    Navigator.push(context, MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return AddPerson(addPerson: _addPerson);
      },
    ));
  }

  void _openEditPerson(Person person, int index) {
    Navigator.push(context, MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return EditPerson(
          savePerson: _savePerson,
          deletePerson: _deletePerson,
          data: person.toMap()
        );
      },
    ));
  }

  void _addPerson(Person person) {
    setState(() {
      _people.add(person);
    });
  }

  void _savePerson(Person person) {
    setState(() {
      Person toBeSaved = _people.singleWhere((p) => p.uuid == person.uuid, orElse: () => null);
      _people[_people.indexOf(toBeSaved)] = person;
    });
  }

  void _deletePerson(Person person) {
    setState(() {
      _people.removeWhere((p) => p.uuid == person.uuid);
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
                    onTap: () { _openEditPerson(person, index); },
                  ),
                );
              },
            ),
            FlatButton(
              onPressed: _openAddPerson,
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
      floatingActionButton: _people.length >= 1
      ? FloatingActionButton(
          onPressed: _openQRScanner,
          tooltip: 'Scan Barcode or Take Picture',
          child: Icon(Icons.photo_camera),
        )
      : null,
    );
  }
}