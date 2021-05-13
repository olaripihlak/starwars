import 'package:hive/hive.dart';
import 'package:star_wars/people/people_response.dart';

class Database {
  static const String BOX_PEOPLE = "BOX_PEOPLE";
  static const String OBJECT_PEOPLE = "OBJECT_PEOPLE";

  Future<void> savePeople(PeopleResponse? peopleResponse) async {
    var box = await _getPeopleDb();
    box.put(OBJECT_PEOPLE, peopleResponse);
  }

  Future<PeopleResponse> getPeople() async {
    var box = await _getPeopleDb();
    return box.get(OBJECT_PEOPLE);
  }

  Future<Box> _getPeopleDb() {
    return Hive.openBox(BOX_PEOPLE);
  }

  clearPeople() {
    Hive.box(BOX_PEOPLE).clear();
  }
}
