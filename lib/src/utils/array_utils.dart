class ArrayUtils {

  static bool areEqual(List a, List b) {
    if (a.length != b.length) {
      return false;
    }
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }

  static T? tryFind<T>(List<T> list, bool Function(T) predicate) {
    for(final item in list) {
      if (predicate(item)) {
        return item;
      }
    }
    return null;
  }
}