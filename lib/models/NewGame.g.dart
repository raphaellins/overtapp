// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NewGame.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewGame _$NewGameFromJson(Map<String, dynamic> json) {
  return NewGame(
    json['initialGameNumber'] as int,
    json['finalGameNumber'] as int,
    json['gameDescription'] as String,
    (json['numbersPlayed'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$NewGameToJson(NewGame instance) => <String, dynamic>{
      'initialGameNumber': instance.initialGameNumber,
      'finalGameNumber': instance.finalGameNumber,
      'gameDescription': instance.gameDescription,
      'numbersPlayed': instance.numbersPlayed,
    };
