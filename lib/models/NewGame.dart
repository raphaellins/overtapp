import 'package:json_annotation/json_annotation.dart';

part 'NewGame.g.dart';

@JsonSerializable()
class NewGame {
  String initialGameNumber;
  String finalGameNumber;
  String descriptionGame;

  NewGame(this.initialGameNumber, this.finalGameNumber, this.descriptionGame);

  factory NewGame.fromJson(Map<String, dynamic> json) =>
      _$NewGameFromJson(json);

  Map<String, dynamic> toJson() => _$NewGameToJson(this);
}
