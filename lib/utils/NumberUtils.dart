class NumberUtils {
  String formatBallNumber(int ballNumber) {
    String ballFormatted = ballNumber.toString().padLeft(2, '0');
    return ballFormatted;
  }
}
