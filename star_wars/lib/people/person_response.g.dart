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
      name: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PersonResponse obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
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
