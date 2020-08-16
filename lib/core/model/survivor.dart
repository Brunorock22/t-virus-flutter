import 'package:t_virus/core/enum/gender.dart';
import 'package:t_virus/core/model/location.dart';

class Survivor {
  String name;
  int age;
  Gender gender;
  LatLog location;

  Survivor({this.name, this.age, this.gender, this.location});
}
