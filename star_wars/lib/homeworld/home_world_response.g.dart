// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_world_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeWorldResponseAdapter extends TypeAdapter<HomeWorldResponse> {
  @override
  final int typeId = 3;

  @override
  HomeWorldResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeWorldResponse(
      name: fields[0] as String?,
      rotation_period: fields[1] as String?,
      orbital_period: fields[2] as String?,
      diameter: fields[3] as String?,
      climate: fields[4] as String?,
      gravity: fields[5] as String?,
      terorain: fields[6] as String?,
      surface_water: fields[7] as String?,
      population: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HomeWorldResponse obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.rotation_period)
      ..writeByte(2)
      ..write(obj.orbital_period)
      ..writeByte(3)
      ..write(obj.diameter)
      ..writeByte(4)
      ..write(obj.climate)
      ..writeByte(5)
      ..write(obj.gravity)
      ..writeByte(6)
      ..write(obj.terorain)
      ..writeByte(7)
      ..write(obj.surface_water)
      ..writeByte(8)
      ..write(obj.population);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeWorldResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
