import 'dart:async';

import 'package:flutter/material.dart';

class Bindable<T> extends ValueNotifier<T> {
  final List<Function(T)> _listeners = [];
  Bindable<T>? _proxySource;

  Bindable(super.value) {
    addListener(_onChange);
  }

  Bindable.proxied(Bindable<T> source) : super(source.value) {
    addListener(_onChange);
    startProxy(source);
  }

  void startProxy(Bindable<T> source) {
    stopProxy();

    _proxySource = source;
    source.bind(_onProxySourceTrigger);
  }

  void stopProxy() {
    if (_proxySource != null) {
      _proxySource!.unbind(_onProxySourceTrigger);
      _proxySource = null;
    }
  }

  void trigger() {
    notifyListeners();
  }

  void bind(Function(T) onValue, {bool trigger = true}) {
    _listeners.add(onValue);
    if (trigger) {
      onValue(value);
    }
  }

  void unbind(Function(T) onValue) {
    _listeners.remove(onValue);
  }

  void modify(Function(T) modifier) {
    modifier(value);
    trigger();
  }

  Future<T> waitForNonNull({
    Duration? timeout
  }) {
    Completer<T> completer = Completer();
    void hook(T newValue) {
      if (newValue != null && !completer.isCompleted) {
        completer.complete(newValue);
      }
    }

    if(timeout != null) {
      Future.delayed(timeout, () {
        if(!completer.isCompleted) {
          completer.complete(value);
        }
      });
    }
    completer.future.then((value) => unbind(hook));
    bind(hook, trigger: true);
    return completer.future;
  }

  Future<T> waitForTrigger({
    bool requireChange = false,
    Duration? timeout,
  }) {
    Completer<T> completer = Completer();
    final prevValue = value;
    void hook(T newValue) {
      if (!completer.isCompleted) {
        if ((requireChange && newValue != prevValue) || !requireChange) {
          completer.complete(newValue);
        }
      }
    }

    if(timeout != null) {
      Future.delayed(timeout, () {
        if(!completer.isCompleted) {
          completer.complete(value);
        }
      });
    }
    completer.future.then((value) => unbind(hook));
    bind(hook, trigger: false);
    return completer.future;
  }

  void _onChange() {
    for (int i = 0; i < _listeners.length; i++) {
      _listeners[i](value);
    }
  }

  void _onProxySourceTrigger(T value) {
    if (value == this.value) {
      trigger();
    } else {
      this.value = value;
    }
  }
}
