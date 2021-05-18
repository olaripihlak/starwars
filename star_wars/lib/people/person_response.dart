import 'package:hive/hive.dart';

part 'person_response.g.dart';

@HiveType(typeId: 2)
class PersonResponse {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? height;
  @HiveField(2)
  final String? mass;
  @HiveField(3)
  final String? hair_color;
  @HiveField(4)
  final String? skin_color;
  @HiveField(5)
  final String? eye_color;
  @HiveField(6)
  final String? birth_year;
  @HiveField(7)
  final String? gender;
  @HiveField(8)
  final String? homeworld;

  PersonResponse({
    this.name,
    this.height,
    this.mass,
    this.hair_color,
    this.skin_color,
    this.eye_color,
    this.birth_year,
    this.gender,
    this.homeworld,
  });

  factory PersonResponse.convertPersonResponse(Map<String, dynamic> json) {
    return PersonResponse(
        name: json['name'],
        height: json['height'],
        mass: json['mass'],
        hair_color: json['hair_color'],
        skin_color: json['skin_color'],
        eye_color: json['eye_color'],
        birth_year: json['birth_year'],
        gender: json['gender'],
        homeworld: json['homeworld']);
  }
}
