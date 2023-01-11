import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final int? code;

  const Failure({this.code});

  @override
  List<Object?> get props => [];
}

class ResponseFailure extends Failure {
  static const int networkErrorCode = 0;
  static const int invalidDataErrorCode = 1;

  final dynamic data;
  final int? statusCode;
  final String? statusMessage;
  final String? path;

  const ResponseFailure({
    this.data,
    this.statusCode,
    this.statusMessage,
    this.path,
  }) : super(code: statusCode);

  @override
  List<Object?> get props => [
        data,
        statusCode,
        statusMessage,
        path,
      ];
}
