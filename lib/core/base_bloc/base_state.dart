import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();

  @override
  List<Object?> get props => [];
}

class InitState extends BaseState {
  const InitState();
}

class LoadingState<T> extends BaseState {
  final T? data;

  const LoadingState({this.data});
}

class LoadedState<T> extends BaseState {
  final T? data;

  const LoadedState({this.data});

  @override
  List<Object?> get props => [data];
}

class ErrorState<T> extends BaseState {
  final int? code;
  final T? data;

  const ErrorState({this.code, this.data});

  @override
  List<Object?> get props => [code, data];
}

class InputState<T> extends BaseState {
  final T? data;

  const InputState({this.data});

  @override
  List<Object?> get props => [data];
}
