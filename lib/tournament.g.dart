// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TournamentAdapter extends TypeAdapter<Tournament> {
  @override
  final int typeId = 1;

  @override
  Tournament read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tournament(
      fields[4] as String,
    )
      ..brackets = (fields[0] as List).cast<Bracket>()
      ..divisions = (fields[1] as List).cast<Division>()
      ..tables = (fields[2] as List).cast<Pairing>()
      ..players = (fields[3] as List).cast<Player>()
      ..lastDivisionAddedTo = fields[5] as int
      ..started = fields[6] as bool
      ..round = fields[7] as int;
  }

  @override
  void write(BinaryWriter writer, Tournament obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.brackets)
      ..writeByte(1)
      ..write(obj.divisions)
      ..writeByte(2)
      ..write(obj.tables)
      ..writeByte(3)
      ..write(obj.players)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.lastDivisionAddedTo)
      ..writeByte(6)
      ..write(obj.started)
      ..writeByte(7)
      ..write(obj.round);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TournamentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
