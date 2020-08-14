class GameDetail {
  List<String> ballsMatched;
  int countMatched;
  String gameDescription;
  String gameId;
  String gameNumber;
  List<String> numbersDrawn;
  List<String> numbersPlayed;

  GameDetail(
      {this.ballsMatched,
      this.countMatched,
      this.gameDescription,
      this.gameId,
      this.gameNumber,
      this.numbersDrawn,
      this.numbersPlayed});

  factory GameDetail.fromJson(Map<String, dynamic> json) {
    print(json['countMatched']);
    return GameDetail(
        ballsMatched: new List<String>.from(['ballsMatched']),
        countMatched: json['countMatched'],
        gameDescription: json['gameDescription'],
        gameId: json['gameId'],
        gameNumber: (json['gameNumber']).toString(),
        numbersDrawn: new List<String>.from(json['numbersDrawn']),
        numbersPlayed: new List<String>.from(json['numbersPlayed']));
  }
}
