import 'package:dio/dio.dart';
import 'package:t_virus/core/backend/backend.dart';
import 'package:t_virus/core/backend/backend_routes.dart';
import 'package:t_virus/core/model/survivor.dart';

class PeopleService {
  Backend backend = Backend.instance();
  Response r;

  Future<bool> registerSurvivor(Survivor survivor) async {
    Backend backend = Backend.instance();
    Response r;
    List<String> items = List();
    survivor.supplies.forEach((element) {
      if (element.quantity > 0) items.add(element.name+":"+element.points.toString());
    });
    try {
      Map data = {
        "name": survivor.name,
        "age": survivor.age,
        "gender": survivor.gender.toString(),
        "lonlat": survivor.location,
        "items": items.toString().replaceAll("[", "").replaceAll("]", "")
      };

      r = await backend.io.post(BackendRoutes.people, data: data);
      if (r.statusCode == 200 || r.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
