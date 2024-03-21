import 'package:jrx_flutter/src/data/event_action.dart';

class EventActionMixin {
  final Map<dynamic, dynamic> _eventActions = {};

  /// Subscribes to the specified event action while silently tracking usage.
  void useEventAction(EventAction eventAction, Function() listener) {
    if (_eventActions.containsKey(eventAction)) {
      throw "This event action is already in use.";
    }
    eventAction.add(listener);
    _eventActions[eventAction] = listener;
  }

  /// Subscribes to the specified event action while silently tracking usage.
  void useEventActionT<T>(EventActionT<T> eventAction, Function(T value) listener) {
    if (_eventActions.containsKey(eventAction)) {
      throw "This event action is already in use.";
    }
    eventAction.add(listener);
    _eventActions[eventAction] = listener;
  }

  /// Subscribes to the specified event action while silently tracking usage.
  void useEventActionTT<T1, T2>(EventActionTT<T1, T2> eventAction, Function(T1 value1, T2 value2) listener) {
    if (_eventActions.containsKey(eventAction)) {
      throw "This event action is already in use.";
    }
    eventAction.add(listener);
    _eventActions[eventAction] = listener;
  }

  /// Unsubscribes from the specified event action.
  void unuseEventAction(EventAction eventAction) {
    if (_eventActions.containsKey(eventAction)) {
      (eventAction as dynamic).remove(_eventActions[eventAction]);
      _eventActions.remove(eventAction);
    }
  }

  /// Unsubscribes from the specified event action.
  void unuseEventActionT<T>(EventActionT<T> eventAction) {
    if (_eventActions.containsKey(eventAction)) {
      (eventAction as dynamic).remove(_eventActions[eventAction]);
      _eventActions.remove(eventAction);
    }
  }

  /// Unsubscribes from the specified event action.
  void unuseEventActionTT<T1, T2>(EventActionTT<T1, T2> eventAction) {
    if (_eventActions.containsKey(eventAction)) {
      (eventAction as dynamic).remove(_eventActions[eventAction]);
      _eventActions.remove(eventAction);
    }
  }

  /// Unsubscribes from all the tracked bindables.
  void unuseAllEventActions() {
    for (final eventAction in _eventActions.keys) {
      eventAction.remove(_eventActions[eventAction]);
    }
    _eventActions.clear();
  }
}
