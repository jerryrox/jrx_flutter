import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

class SystemUtils {
  static bool get isWeb => kIsWeb;
  static bool get isAndroid => !isWeb && Platform.isAndroid;
  static bool get isIOS => !isWeb && Platform.isIOS;
  static bool get isMobile => isAndroid || isIOS;

  static Future copyToClipboard(String text) {
    return Clipboard.setData(ClipboardData(text: text));
  }
}
