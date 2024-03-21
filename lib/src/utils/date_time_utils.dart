class DateTimeUtils {
  static bool areDifferentMinute(DateTime x, DateTime y) {
    final utcX = x.toUtc();
    final utcY = y.toUtc();
    return utcX.minute != utcY.minute || utcX.difference(utcY).inMinutes > 0;
  }

  static bool areDifferentDays(DateTime x, DateTime y) {
    return x.year != y.year || x.month != y.month || x.day != y.day;
  }

  static int differenceInMs(DateTime x, DateTime y) {
    final diff = x.millisecondsSinceEpoch - y.millisecondsSinceEpoch;
    return diff < 0 ? -diff : diff;
  }
}
