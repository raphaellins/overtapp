import 'package:rxdart/rxdart.dart';

enum BallStateEnum { INITIATED, RESET }

class BallController {
  BallStateEnum ballState = BallStateEnum.INITIATED;

  BehaviorSubject<BallStateEnum> _subjectBallEnabled;

  BallController() {
    _subjectBallEnabled =
        new BehaviorSubject<BallStateEnum>.seeded(this.ballState);
  }

  ValueStream<BallStateEnum> get counterObservable =>
      _subjectBallEnabled.stream;

  void dispose() {
    _subjectBallEnabled.close();
  }

  void reset() {
    _subjectBallEnabled.sink.add(BallStateEnum.RESET);
    _subjectBallEnabled.sink.add(BallStateEnum.INITIATED);
  }
}
