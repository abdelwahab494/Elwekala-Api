import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_api/core/shared/data/models/auth_model.dart';
import 'package:products_api/core/shared/data/repos/api/api_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final ApiRepo apiRepo;
  LoginCubit(this.apiRepo) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final AuthModel model = await apiRepo.login(email, password);
      emit(LoginLoaded(message: model.message));
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String nationalId,
    required String gender,
    String image =
        "data:image/png;base64,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",
  }) async {
    emit(LoginLoading());
    try {
      final AuthModel model = await apiRepo.signUp(
        name: name,
        email: email,
        password: password,
        phone: phone,
        nationalId: nationalId,
        gender: gender,
        image: image,
      );
      emit(LoginLoaded(message: model.message));
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }
}
