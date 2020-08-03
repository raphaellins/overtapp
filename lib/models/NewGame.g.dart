// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NewGame.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewGame _$NewGameFromJson(Map<String, dynamic> json) {
  return NewGame(
    json['initialGameNumber'] as String,
    json['finalGameNumber'] as String,
    json['descriptionGame'] as String,
  );
}

Map<String, dynamic> _$NewGameToJson(NewGame instance) => <String, dynamic>{
      'initialGameNumber': instance.initialGameNumber,
      'finalGameNumber': instance.finalGameNumber,
      'descriptionGame': instance.descriptionGame,
    };
