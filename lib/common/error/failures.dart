import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  const Failure({this.message});

  @override
  List<Object?> get props => [];
}

class ConnectionFailure extends Failure {
  const ConnectionFailure() : super();

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure({String? message}) : super(message: message);

  @override
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure {
  const EmptyCacheFailure({String? message}) : super(message: message);

  @override
  List<Object?> get props => [];
}

class CommonFailure extends Failure {
  const CommonFailure({String? message}) : super(message: message);

  @override
  List<Object?> get props => [];
}

class TimeOutFailure extends Failure {
  const TimeOutFailure({String? message}) : super(message: message);

  @override
  List<Object?> get props => [];
}
