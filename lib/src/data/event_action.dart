class EventAction {
  final List<Function()?> _callbacks = [];
  
  void add(Function() callback) {
    _callbacks.add(callback);
  }
  
  void remove(Function()? callback) {
    if(callback == null) {
      return;
    }
    for(int i=0; i<_callbacks.length; i++) {
      if(_callbacks[i] == callback) {
        _callbacks[i] = null;
        break;
      }
    }
  }
  
  void invoke() {
    for(int i=0; i<_callbacks.length; i++) {
      if(_callbacks[i] == null) {
        _callbacks.removeAt(i--);
        continue;
      }
      _callbacks[i]!();
    }
  }
}

class EventActionT<T> {
  final List<Function(T t)?> _callbacks = [];
  
  void add(Function(T t) callback) {
    _callbacks.add(callback);
  }
  
  void remove(Function(T t)? callback) {
    if(callback == null) {
      return;
    }
    for(int i=0; i<_callbacks.length; i++) {
      if(_callbacks[i] == callback) {
        _callbacks[i] = null;
        break;
      }
    }
  }
  
  void invoke(T t) {
    for(int i=0; i<_callbacks.length; i++) {
      if(_callbacks[i] == null) {
        _callbacks.removeAt(i--);
        continue;
      }
      _callbacks[i]!(t);
    }
  }
}

class EventActionTT<T, T2> {
  final List<Function(T t, T2 t2)?> _callbacks = [];
  
  void add(Function(T t, T2) callback) {
    _callbacks.add(callback);
  }
  
  void remove(Function(T t, T2 t2)? callback) {
    if(callback == null) {
      return;
    }
    for(int i=0; i<_callbacks.length; i++) {
      if(_callbacks[i] == callback) {
        _callbacks[i] = null;
        break;
      }
    }
  }
  
  void invoke(T t, T2 t2) {
    for(int i=0; i<_callbacks.length; i++) {
      if(_callbacks[i] == null) {
        _callbacks.removeAt(i--);
        continue;
      }
      _callbacks[i]!(t, t2);
    }
  }
}