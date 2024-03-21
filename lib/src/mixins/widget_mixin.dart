import 'package:flutter/material.dart';

mixin WidgetMixin {
  double getScreenWidth(BuildContext context) {
    final query = MediaQuery.of(context);
    return query.size.width;
  }

  double getScreenHeight(BuildContext context) {
    final query = MediaQuery.of(context);
    return query.size.height;
  }

  EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  void removeFocus(BuildContext context) {
    FocusScopeNode node = FocusScope.of(context);
    if (!node.hasPrimaryFocus && node.focusedChild != null) {
      node.focusedChild!.unfocus();
    }
  }

  void runAfterFrame(Function() callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
}
