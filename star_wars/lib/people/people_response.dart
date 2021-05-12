import 'package:star_wars/people/person_response.dart';

class PeopleResponse {
  final int count;
  final List<PersonResponse> personResponse;

  PeopleResponse({required this.count, required this.personResponse});

  factory PeopleResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> events = json['results'];
    List<PersonResponse> personList =
        events.map((e) => PersonResponse.convertPersonResponse(e)).toList();

    return PeopleResponse(count: json['count'], personResponse: personList);
  }
}
