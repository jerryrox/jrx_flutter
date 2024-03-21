import 'package:jrx_flutter/src/data/bindable.dart';

mixin BindableMixin {

  final Map<dynamic, dynamic> _bindables = {};

  void useBindable<T>(Bindable<T> bindable, Function(T) listener, {bool trigger = true}) {
    if(_bindables.containsKey(bindable)) {
      throw "This bindable is already in use.";
    }
    bindable.bind(listener, trigger: trigger);
    _bindables[bindable] = listener;
  }

  void unuseBindable<T>(Bindable<T> bindable) {
    if(_bindables.containsKey(bindable)) {
      (bindable as dynamic).unbind(_bindables[bindable]);
      _bindables.remove(bindable);
    }
  }

  void unuseAllBindables() {
    for(final bindable in _bindables.keys) {
      bindable.unbind(_bindables[bindable]);
    }
    _bindables.clear();
  }
}