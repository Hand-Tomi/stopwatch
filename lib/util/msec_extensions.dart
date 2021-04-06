extension DisplayTimeParsing on int {
  String parseDisplayTime() {
    final minute = (this / (60 * 1000)).floor().toString().padLeft(2, '0');
    final second =
        (this % (60 * 1000) / 1000).floor().toString().padLeft(2, '0');
    final milliSecond = (this % 1000 / 10).floor().toString().padLeft(2, '0');

    return '$minute:$second:$milliSecond';
  }

  String parseDisplayTimeOfSeconds() {
    final minute = (this / (60)).floor().toString().padLeft(2, '0');
    final second = (this % 60).floor().toString().padLeft(2, '0');
    return '$minute:$second';
  }
}
