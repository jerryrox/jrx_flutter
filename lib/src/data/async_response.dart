class AsyncResponse<T> {
  bool isSuccess;
  String message;
  String? code;
  String? error;
  Map? errorParams;
  T? data;

  AsyncResponse(
    this.isSuccess,
    this.message, {
    this.code,
    this.error,
    this.errorParams,
    this.data,
  });

  factory AsyncResponse.success(
    T? data, {
    String message = "",
    String? code,
  }) {
    return AsyncResponse(
      true,
      message,
      code: code,
      data: data,
    );
  }

  factory AsyncResponse.error(
    String message, {
    String? code,
    String? error,
    Map? errorParams,
  }) {
    return AsyncResponse(
      false,
      message,
      code: code,
      error: error,
      errorParams: errorParams,
    );
  }

  AsyncResponse<T> addErrorParams(Map newParams) {
    if (errorParams == null) {
      errorParams = newParams;
      return this;
    }
    errorParams!.addAll(newParams);
    return this;
  }
}
