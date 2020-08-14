import 'package:json_annotation/json_annotation.dart';

part 'NewGame.g.dart';

@JsonSerializable()
class NewGame {
  final int initialGameNumber;
  final int finalGameNumber;
  final String gameDescription;
  final List<String> numbersPlayed;

  NewGame(this.initialGameNumber, this.finalGameNumber, this.gameDescription,
      this.numbersPlayed);

  factory NewGame.fromJson(Map<String, dynamic> json) =>
      _$NewGameFromJson(json);

  Map<String, dynamic> toJson() => _$NewGameToJson(this);
}
