// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeopleResponseAdapter extends TypeAdapter<PeopleResponse> {
  @override
  final int typeId = 1;

  @override
  PeopleResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PeopleResponse(
      count: fields[0] as int,
      personResponse: (fields[1] as List).cast<PersonResponse>(),
    );
  }

  @override
  void write(BinaryWriter writer, PeopleResponse obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.personResponse);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeopleResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
