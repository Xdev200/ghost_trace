// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameStatsAdapter extends TypeAdapter<GameStats> {
  @override
  final int typeId = 0;

  @override
  GameStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameStats(
      totalScore: fields[0] as int,
      bestRoundScore: fields[1] as int,
      longestStreak: fields[2] as int,
      currentStreak: fields[3] as int,
      bestPathLength: fields[4] as int,
      totalGamesPlayed: fields[5] as int,
      totalCorrectTaps: fields[6] as int,
      totalTaps: fields[7] as int,
      lastPlayedDate: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, GameStats obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.totalScore)
      ..writeByte(1)
      ..write(obj.bestRoundScore)
      ..writeByte(2)
      ..write(obj.longestStreak)
      ..writeByte(3)
      ..write(obj.currentStreak)
      ..writeByte(4)
      ..write(obj.bestPathLength)
      ..writeByte(5)
      ..write(obj.totalGamesPlayed)
      ..writeByte(6)
      ..write(obj.totalCorrectTaps)
      ..writeByte(7)
      ..write(obj.totalTaps)
      ..writeByte(8)
      ..write(obj.lastPlayedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
