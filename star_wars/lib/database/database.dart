import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:star_wars/people/people_response.dart';
import 'package:star_wars/people/person_response.dart';

class Database {
  static const String BOX_PEOPLE = "BOX_PEOPLE";
  static const String OBJECT_PEOPLE = "OBJECT_PEOPLE";
  Box<PeopleResponse>? peopleBox;

  Database._privateConstructor();

  static final Database _instance = Database._privateConstructor();

  static Database get instance {
    return _instance;
  }

  Future<void> initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(PeopleResponseAdapter());
    Hive.registerAdapter(PersonResponseAdapter());
    peopleBox = await Hive.openBox<PeopleResponse>(BOX_PEOPLE);
  }

  Future<void> savePeople(PeopleResponse peopleResponse) async {
    Hive.box<PeopleResponse>(BOX_PEOPLE).put(OBJECT_PEOPLE, peopleResponse);
  }

  Box<PeopleResponse> getPeople() {
    return Hive.box<PeopleResponse>(BOX_PEOPLE);
  }
}
