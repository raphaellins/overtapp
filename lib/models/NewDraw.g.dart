// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NewDraw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewDraw _$NewDrawFromJson(Map<String, dynamic> json) {
  return NewDraw(
    json['drawNumber'] as String,
    json['drawDate'] as String,
    (json['numbersDrawn'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$NewDrawToJson(NewDraw instance) => <String, dynamic>{
      'drawNumber': instance.drawNumber,
      'numbersDrawn': instance.numbersDrawn,
      'drawDate': instance.drawDate,
    };
