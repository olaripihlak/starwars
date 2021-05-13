import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:star_wars/database/database.dart';
import 'package:star_wars/people/people_response.dart';

class PeopleRequest {
  Future<PeopleResponse> requestPeople(Database database) async {
    var url = Uri.parse('https://swapi.dev/api/people/');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var people = PeopleResponse.fromJson(jsonDecode(response.body));
        database.savePeople(people);
        return people;
      } else {
        return database.getPeople();
      }
    } on Exception {
      return database.getPeople();
    }
  }
}
