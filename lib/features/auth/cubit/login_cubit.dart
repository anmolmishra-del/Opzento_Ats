import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/features/auth/state/login_state.dart';


class LoginCubit
    extends Cubit<LoginState> {

  LoginCubit()
      : super(const LoginState());

  void togglePassword() {

    emit(

      state.copyWith(

        obscurePassword:
            !state.obscurePassword,
      ),
    );
  }

  void toggleRememberMe(bool value) {

    emit(
      state.copyWith(
        rememberMe: value,
      ),
    );
  }

  Future<void> login({

    required String email,
    required String password,
  }) async {

    emit(
      state.copyWith(
        status: LoginStatus.loading,
      ),
    );

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (email == "admin@gmail.com" &&
        password == "123456") {

      emit(
        state.copyWith(
          status: LoginStatus.success,
        ),
      );

    } else {

      emit(
        state.copyWith(
          status: LoginStatus.error,
          message: "Invalid Credentials",
        ),
      );
    }
  }
}