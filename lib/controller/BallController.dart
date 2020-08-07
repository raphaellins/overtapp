import 'package:rxdart/rxdart.dart';

class BallController {
  bool initialState = false;

  BehaviorSubject<bool> _subjectBallEnabled;

  BallController() {
    _subjectBallEnabled = new BehaviorSubject<bool>.seeded(this.initialState);
  }

  ValueStream<bool> get counterObservable => _subjectBallEnabled.stream;

  void enable() {
    _subjectBallEnabled.sink.add(true);
  }

  void disable() {
    _subjectBallEnabled.sink.add(false);
  }

  void dispose() {
    _subjectBallEnabled.close();
  }
}
