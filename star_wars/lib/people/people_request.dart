import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:star_wars/people/people_response.dart';

class PeopleRequest {
  Future<PeopleResponse> requestPeople() async {
    var url = Uri.parse('https://swapi.dev/api/people/');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return PeopleResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load people');
    }
  }
}
