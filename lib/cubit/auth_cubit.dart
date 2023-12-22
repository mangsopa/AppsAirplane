import 'package:airplaneapps/models/user_model.dart';
import 'package:airplaneapps/services/auth_service.dart';
import 'package:airplaneapps/services/user_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void register(
      {required String email,
      required String password,
      required String name,
      String hobby = ''}) async {
    try {
      emit(AuthLoading());

      UserModel user = await AuthService()
          .register(email: email, password: password, name: name, hobby: hobby);

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signOut() async {
    try {
      emit(AuthLoading());
      await AuthService().signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void getCurrenntUser(String id) async {
    try {
      UserModel user = await UserService().getUserById(id);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
