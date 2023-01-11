import 'package:flutter_bloc/flutter_bloc.dart';

class BaseCubit<T> extends Cubit<T> with _BaseCubitMixin {
  BaseCubit(T initialState) : super(initialState);
}

abstract class BaseBloc<Event, State> extends Bloc<Event, State> with _BaseCubitMixin {
  BaseBloc(State initialState) : super(initialState);
}

mixin _BaseCubitMixin {
  // BaseState getErrorState(e) {
  //   try {
  //     if (e is ErrorResponse) {
  //       final errorModel = ErrorResponseModel.fromMap(e.data);
  //       return ErrorState(code: e.statusCode, data: errorModel.message);
  //     }
  //   } catch (err) {
  //     debugPrint(err.toString());
  //   }
  //   debugPrint(e.toString());
  //   return ErrorState(data: S.current.some_thing_wrong);
  // }
}
