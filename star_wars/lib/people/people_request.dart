import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:star_wars/people/people_response.dart';

class PeopleRequest {
  Future<PeopleResponse> requestPeople() async {
    var url = Uri.parse('https://swapi.dev/api/people/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return PeopleResponse.fromJson(jsonDecode(response.body));
      }
      return throw "Server error!";
    } on SocketException catch (_) {
      return throw "No internet connection!";
    } catch (err) {
      return throw "Something went wrong!";
    }
  }
}
