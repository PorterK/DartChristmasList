import 'gift.dart';
import 'wish.dart';

class Person {
  String uuid;
  String name;
  String shirtSize;
  String pantsSize;
  String shoeSize;
  String notes;

  List<Gift> gifts = [];
  List<Wish> wishes = [];
}