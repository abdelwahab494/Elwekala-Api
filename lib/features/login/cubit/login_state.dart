part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginLoaded extends LoginState {
  final String message;

  const LoginLoaded({required this.message});
}

final class LoginError extends LoginState {
  final String message;

  const LoginError({required this.message});
}
