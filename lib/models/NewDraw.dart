import 'package:json_annotation/json_annotation.dart';

part 'NewDraw.g.dart';

@JsonSerializable()
class NewDraw {
  int drawNumber;
  List<String> numbersDrawn;
  String drawDate;

  NewDraw(this.drawNumber, this.drawDate, this.numbersDrawn);

  factory NewDraw.fromJson(Map<String, dynamic> json) =>
      _$NewDrawFromJson(json);

  Map<String, dynamic> toJson() => _$NewDrawToJson(this);
}
