import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:star_wars/people/people_response.dart';

enum RequestMethod {
  get,
}

class ApiService {
  ApiService._privateConstructor();

  static final ApiService _instance = ApiService._privateConstructor();

  static ApiService get instance {
    return _instance;
  }

  Future<PeopleResponse> requestPeople() async {
    return apiRequest<PeopleResponse>('https://swapi.dev/api/people/',
        RequestMethod.get, (json) => PeopleResponse.fromJson(json));
  }

  Future<T> apiRequest<T>(String uri, RequestMethod method,
      T Function(Map<String, dynamic> json) fromJson) async {
    if (method != RequestMethod.get) {
      return throw "Http method not supported";
    }

    try {
      var url = Uri.parse(uri);
      // Add other methods also e.g http.post().
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return fromJson(jsonDecode(response.body));
      }
      return throw "Server error!";
    } on SocketException catch (_) {
      return throw "No internet connection!";
    } catch (err) {
      print("ApiService error: " + err.toString());
      return throw "Something went wrong: " + err.toString();
    }
  }
}
