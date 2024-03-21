class Lazy<T> {
  final T Function() _getValue;
  T? _value;

  Lazy(this._getValue);

  T get value {
    _value ??= _getValue();
    return _value!;
  }
}
