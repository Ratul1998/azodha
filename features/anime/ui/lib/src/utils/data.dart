class Data<T extends Object> {
  final bool loading;
  final T? data;
  final Object? error;
  final StackTrace? trace;

  const Data({this.loading = true, this.data, this.error, this.trace});

  factory Data.loading([T? data]) => Data(loading: true, data: data);

  factory Data.loaded(T data) => Data(loading: false, data: data);

  factory Data.error({required Object error, StackTrace? str}) =>
      Data(loading: false, error: error, trace: str);

  bool get isLoading => loading;

  bool get hasError => !loading && error != null;

  bool get isSuccess => !loading && error == null;

  S map<S>({
    required S Function(bool loading, T? data) onLoading,
    required S Function(Object err, StackTrace? str) onError,
    required S Function(T data) onData,
  }) => isLoading
      ? onLoading.call(loading, data)
      : hasError
      ? onError.call(error!, trace)
      : onData.call(data!);
}
