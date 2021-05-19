import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:star_wars/homeworld/home_world_response.dart';
import 'package:star_wars/people/people_response.dart';
import 'package:star_wars/people/person_response.dart';

class Database {
  static const String BOX_STAR_WARS = "BOX_STAR_WARS";
  static const String BOX_HOME_WORLD = "BOX_HOME_WORLD";
  static const String OBJECT_PEOPLE = "OBJECT_PEOPLE";
  Box<PeopleResponse>? peopleBox;
  Box<HomeWorldResponse>? homeWorldBox;

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
    Hive.registerAdapter(HomeWorldResponseAdapter());
    peopleBox = await Hive.openBox<PeopleResponse>(BOX_STAR_WARS);
    homeWorldBox = await Hive.openBox<HomeWorldResponse>(BOX_HOME_WORLD);
  }

  Future<void> savePeople(PeopleResponse peopleResponse) async {
    Hive.box<PeopleResponse>(BOX_STAR_WARS).put(OBJECT_PEOPLE, peopleResponse);
  }

  Future<void> saveHomeWorld(
      String id, HomeWorldResponse homeWorldResponse) async {
    Hive.box<HomeWorldResponse>(BOX_HOME_WORLD).put(id, homeWorldResponse);
  }

  Box<PeopleResponse> getPeople() {
    return Hive.box<PeopleResponse>(BOX_STAR_WARS);
  }

  Box<HomeWorldResponse> getHomeWorld() {
    return Hive.box<HomeWorldResponse>(BOX_HOME_WORLD);
  }
}
