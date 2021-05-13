import 'package:hive/hive.dart';

part 'person_response.g.dart';

@HiveType(typeId: 2)
class PersonResponse {
  @HiveField(0)
  final String name;

  PersonResponse({required this.name});

  factory PersonResponse.convertPersonResponse(Map<String, dynamic> json) {
    return PersonResponse(name: json['name']);
  }
}
