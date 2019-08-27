import 'package:uuid/uuid.dart';

import 'gift.dart';
import 'wish.dart';

class Person {
  String uuid = Uuid().v4();
  String name;
  String shirtSize;
  String pantsSize;
  String shoeSize;
  String notes;

  List<Gift> gifts = [];
  List<Wish> wishes = [];

  from(Map data) {
    if(data.length == 0) return;

    this.uuid      = data['uuid'];
    this.name      = data['name'];
    this.shirtSize = data['shirtSize'];
    this.pantsSize = data['pantsSize'];
    this.shoeSize  = data['shoeSize'];
    this.notes     = data['notes'];
  }

  Map toMap() {
    Map map = new Map();

    map['uuid']      = this.uuid;
    map['name']      = this.name;
    map['shirtSize'] = this.shirtSize;
    map['pantsSize'] = this.pantsSize;
    map['shoeSize']  = this.shoeSize;
    map['notes']     = this.notes;

    return map;
  }
}