import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingState<T> {
  const LoadingState({
    this.state = LoadingStateEnum.initial,
    this.data,
    this.error,
  });

  final LoadingStateEnum state;
  final T? data;
  final Object? error;

  bool get isLoading => state == LoadingStateEnum.loading;
  bool get hasError => state == LoadingStateEnum.error;
  bool get isSuccess => state == LoadingStateEnum.success;
  bool get isInitial => state == LoadingStateEnum.initial;
  bool get hasData => data != null;

  LoadingState<T> copyWith({
    LoadingStateEnum? state,
    T? data,
    Object? error,
  }) {
    return LoadingState<T>(
      state: state ?? this.state,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  /// Factory constructors for common states
  factory LoadingState.initial() => const LoadingState();

  factory LoadingState.loading([T? data]) => LoadingState(
        state: LoadingStateEnum.loading,
        data: data,
      );

  factory LoadingState.success(T data) => LoadingState(
        state: LoadingStateEnum.success,
        data: data,
      );

  factory LoadingState.error(Object error, [T? data]) => LoadingState(
        state: LoadingStateEnum.error,
        error: error,
        data: data,
      );

  @override
  String toString() {
    return 'LoadingState(state: $state, data: $data, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoadingState<T> &&
        other.state == state &&
        other.data == data &&
        other.error == error;
  }

  @override
  int get hashCode => Object.hash(state, data, error);
}

enum LoadingStateEnum {
  initial,
  loading,
  success,
  error,
}

extension AsyncValueToLoadingState<T> on AsyncValue<T> {
  LoadingState<T> toLoadingState() {
    return when(
      data: (data) => LoadingState.success(data),
      loading: () => LoadingState.loading(),
      error: (error, _) => LoadingState.error(error),
    );
  }
}

extension LoadingStateExtension<T> on LoadingState<T> {
  R? whenSuccess<R>(R Function(T data) callback) {
    if (isSuccess && data != null) {
      return callback(data as T);
    }
    return null;
  }

  R? whenError<R>(R Function(Object error) callback) {
    if (hasError && error != null) {
      return callback(error!);
    }
    return null;
  }

  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(Object error) error,
  }) {
    switch (state) {
      case LoadingStateEnum.initial:
        return initial();
      case LoadingStateEnum.loading:
        return loading();
      case LoadingStateEnum.success:
        return success(data as T);
      case LoadingStateEnum.error:
        return error(this.error!);
    }
  }
}
