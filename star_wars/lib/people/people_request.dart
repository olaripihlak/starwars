import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:star_wars/database/database.dart';
import 'package:star_wars/people/people_response.dart';

class PeopleRequest {
  Future<String?> requestPeople(Database database) async {
    var url = Uri.parse('https://swapi.dev/api/people/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var people = PeopleResponse.fromJson(jsonDecode(response.body));
        database.savePeople(people);
        return null;
      }
      return throw "Refresh data failed!";
    } on SocketException catch (_) {
      return throw "No connection";
    } catch (err) {
      return throw "Something went wrong!";
    }
  }
}
