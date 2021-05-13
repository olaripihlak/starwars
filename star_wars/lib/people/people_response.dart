import 'package:hive/hive.dart';
import 'package:star_wars/people/person_response.dart';

part 'people_response.g.dart';

@HiveType(typeId: 1)
class PeopleResponse extends HiveObject {
  @HiveField(0)
  final int count;
  @HiveField(1)
  final List<PersonResponse> personResponse;

  PeopleResponse({required this.count, required this.personResponse});

  factory PeopleResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> events = json['results'];
    List<PersonResponse> personList =
        events.map((e) => PersonResponse.convertPersonResponse(e)).toList();

    return PeopleResponse(count: json['count'], personResponse: personList);
  }
}
