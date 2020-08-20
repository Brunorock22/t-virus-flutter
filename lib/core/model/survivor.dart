import 'package:t_virus/core/model/supplie.dart';

class Survivor {
  int id;
  String name;
  int age;
  int autologin;
  String gender;
  String location;
  List<Supplie> supplies;

  Survivor({this.id,this.name, this.age, this.gender, this.location, this.supplies,this.autologin});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'autologin': autologin,
      'location': location,
      'supplies': supplies,
    };
  }

  Survivor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
    location = json['lonlat'];
  }
}
