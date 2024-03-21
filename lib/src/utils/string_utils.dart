class StringUtils {

  static String combine(List<String?> segments, {bool leadSeparator = true, String separator = "/"}) {
    String path = "";
    for (String? segment in segments) {
      if (segment != null) {
        segment = segment.trim();
        if (segment.isNotEmpty) {
          path = "$path$separator$segment";
        }
      }
    }

    path = path.isEmpty ? separator : path;
    if (!leadSeparator) {
      path = path.substring(1);
    }
    return path;
  }
}