import 'package:jrx_flutter/src/data/async_response.dart';

abstract class BaseApi<T> {

  String get genericErrorMessage;

  Future<AsyncResponse<T>> request() async {
    try {
      return await requestInternal();
    } catch (e) {
      return Future.value(AsyncResponse.error(genericErrorMessage, error: e.toString()));
    }
  }

  Future<AsyncResponse<T>> requestInternal();
}
