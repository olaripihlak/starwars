// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonResponseAdapter extends TypeAdapter<PersonResponse> {
  @override
  final int typeId = 2;

  @override
  PersonResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonResponse(
      name: fields[0] as String?,
      height: fields[1] as String?,
      mass: fields[2] as String?,
      hair_color: fields[3] as String?,
      skin_color: fields[4] as String?,
      eye_color: fields[5] as String?,
      birth_year: fields[6] as String?,
      gender: fields[7] as String?,
      homeworld: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PersonResponse obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.mass)
      ..writeByte(3)
      ..write(obj.hair_color)
      ..writeByte(4)
      ..write(obj.skin_color)
      ..writeByte(5)
      ..write(obj.eye_color)
      ..writeByte(6)
      ..write(obj.birth_year)
      ..writeByte(7)
      ..write(obj.gender)
      ..writeByte(8)
      ..write(obj.homeworld);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
