import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  final String failure;
  ServerFailure({required this.failure});
  @override
  List<Object?> get props => [failure];
}

class InternetFailure extends Failure {
  final String failure;
  InternetFailure({required this.failure});
  @override
  List<Object?> get props => [failure];
}
