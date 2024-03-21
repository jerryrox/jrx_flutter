import 'dart:async';

class FutureUtils {
  static Future interval(
    bool Function() condition,
    Duration interval,
    int maxCount, {
    Function()? onTimeout,
  }) async {
    int count = 0;
    while (count < maxCount) {
      if (condition()) {
        return;
      }
      await Future.delayed(interval);
      count++;
    }
    if (onTimeout != null) {
      onTimeout();
    }
    throw TimeoutException("Interval conditional check timed out");
  }
}
