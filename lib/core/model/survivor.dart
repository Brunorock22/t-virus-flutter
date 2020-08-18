import 'package:t_virus/core/model/supplie.dart';

class Survivor {
  int id;
  String name;
  int age;
  String gender;
  String location;
  List<Supplie> supplies;

  Survivor({this.id,this.name, this.age, this.gender, this.location, this.supplies});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'location': location,
      'supplies': supplies,
    };
  }
}
