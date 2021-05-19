import 'package:hive/hive.dart';

part 'home_world_response.g.dart';

@HiveType(typeId: 3)
class HomeWorldResponse extends HiveObject {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? rotation_period;
  @HiveField(2)
  final String? orbital_period;
  @HiveField(3)
  final String? diameter;
  @HiveField(4)
  final String? climate;
  @HiveField(5)
  final String? gravity;
  @HiveField(6)
  final String? terorain;
  @HiveField(7)
  final String? surface_water;
  @HiveField(8)
  final String? population;

  HomeWorldResponse({
    this.name,
    this.rotation_period,
    this.orbital_period,
    this.diameter,
    this.climate,
    this.gravity,
    this.terorain,
    this.surface_water,
    this.population,
  });

  factory HomeWorldResponse.fromJson(Map<String, dynamic> json) {
    return HomeWorldResponse(
      name: json['name'],
      rotation_period: json['rotation_period'],
      orbital_period: json['orbital_period'],
      diameter: json['diameter'],
      climate: json['climate'],
      gravity: json['gravity'],
      terorain: json['terorain'],
      surface_water: json['surface_water'],
      population: json['population'],
    );
  }
}
