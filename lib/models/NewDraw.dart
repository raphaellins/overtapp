import 'package:json_annotation/json_annotation.dart';

part 'NewDraw.g.dart';

@JsonSerializable()
class NewDraw {
  String drawNumber;
  String numbersDrawn;
  DateTime drawDate;

  NewDraw(this.drawNumber, this.numbersDrawn, this.drawDate);

  factory NewDraw.fromJson(Map<String, dynamic> json) =>
      _$NewDrawFromJson(json);

  Map<String, dynamic> toJson() => _$NewDrawToJson(this);
}
