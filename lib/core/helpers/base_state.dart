class CubitStates {}

class LoadingState extends CubitStates {}

class FailedState extends LoadingState {
  String message;
  FailedState({required this.message});
}

class LoadedState<T> extends LoadingState {
  final T data;
  LoadedState({required this.data});
}
