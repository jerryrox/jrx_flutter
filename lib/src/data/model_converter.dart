abstract class ModelConverter<T> {
  final List<ModelConverter> subConverters = [];

  T toModel(String id, dynamic data);

  T? toModelSafe(String id, dynamic data) {
    try {
      return toModel(id, data);
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> toPlain(T model);

  dynamic encodeDate(DateTime value) {
    return value.toIso8601String();
  }

  DateTime decodeDate(dynamic value, [DateTime? defaultValue]) {
    if (value is String) {
      return DateTime.parse(value);
    }
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    return defaultValue ?? DateTime.now();
  }

  dynamic encodeString(String value) {
    return value.toString();
  }

  String decodeString(dynamic value, [String defaultValue = ""]) {
    if (value == null) {
      return defaultValue;
    }
    return value.toString();
  }

  Iterable<dynamic> decodeIterable(dynamic value, [Iterable<dynamic>? defaultValue]) {
    if (value is Iterable<dynamic>) {
      return value;
    }
    return defaultValue ?? [];
  }

  Map<dynamic, dynamic> encodeMap<TKey, TValue>(
    Map<TKey, TValue> value,
    dynamic Function(TKey data) keyEncoder,
    dynamic Function(TValue? data) valueEncoder,
  ) {
    final map = <dynamic, dynamic>{};
    for (final key in value.keys) {
      map[keyEncoder(key)] = valueEncoder(value[key]);
    }
    return map;
  }

  Map<TKey, TValue> decodeMap<TKey, TValue>(
    dynamic value,
    TKey Function(dynamic data) keyDecoder,
    TValue Function(dynamic data) valueDecoder, [
    Map<TKey, TValue>? defaultValue,
  ]) {
    final map = <TKey, TValue>{};
    if (value is Map<dynamic, dynamic>) {
      for (final key in value.keys) {
        map[keyDecoder(key)] = valueDecoder(value[key]);
      }
      return map;
    }
    return defaultValue ?? map;
  }

  int decodeInt(dynamic value, [int defaultValue = 0]) {
    if (value is num) {
      return value.toInt();
    }
    return defaultValue;
  }

  double decodeDouble(dynamic value, [double defaultValue = 0.0]) {
    if (value is num) {
      return value.toDouble();
    }
    return defaultValue;
  }

  List<TOutput> encodeArray<TInput, TOutput>(List<TInput> value, TOutput Function(TInput data) encoder) {
    return value.map(encoder).toList();
  }

  List<TValue> decodeArray<TValue>(dynamic value, TValue Function(dynamic data) decoder,
      [List<TValue>? defaultValue]) {
    if (value is Iterable<dynamic>) {
      return value.map(decoder).toList();
    }
    return defaultValue ?? [];
  }

  dynamic encodeBool(bool value) {
    return value;
  }

  bool decodeBool(dynamic value, [bool defaultValue = false]) {
    if (value == null) {
      return defaultValue;
    }
    return (value ?? defaultValue) as bool;
  }

  dynamic encodeNumber(num value) {
    return value;
  }

  Map<dynamic, dynamic> encodeMapFromArray<T2>(
      List<T2> array, Function(T2 item, Map<dynamic, dynamic> map) encoder) {
    Map<dynamic, dynamic> map = {};
    for (final item in array) {
      encoder(item, map);
    }
    return map;
  }
}
