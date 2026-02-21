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
  final ProfileModel userData;

  const LoginLoaded({required this.message, required this.userData});
}

final class LoginError extends LoginState {
  final String message;

  const LoginError({required this.message});
}
