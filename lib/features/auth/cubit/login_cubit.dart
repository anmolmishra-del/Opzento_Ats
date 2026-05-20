import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< HEAD
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:opsento_ats/core/services/api_service.dart';
import 'package:opsento_ats/features/auth/state/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
=======
import 'package:opsento_ats/features/auth/state/login_state.dart';
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc


class LoginCubit
    extends Cubit<LoginState> {

  LoginCubit()
      : super(const LoginState());
<<<<<<< HEAD
final service = OdooService();
  final storage =
      FlutterSecureStorage();
=======
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc

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
<<<<<<< HEAD
Future<void> login({

  required String email,
  required String password,

}) async {

  emit(
    state.copyWith(
      status: LoginStatus.loading,
    ),
  );

  try {
    final response =
        await service.login(

      email: email,
      password: password,
    );

    print(response);
    if (state.rememberMe) {

 

await storage.write(
  key: "isLogin",
  value: "true",
);
   await storage.write(
        key: "token",
        value: response.toString(),
      );
await storage.write(
  key: "email",
  value: email,
);

// await storage.write(
//   key: "password",
//   value: password,
// );
print('Login Saved');
}

    emit(
      state.copyWith(
        status: LoginStatus.success,
      ),
    );

  } catch (e) {

    emit(
      state.copyWith(
        status: LoginStatus.error,
        message: "Login Failed",
      ),
    );
  }
}
  // Future<void> login({

  //   required String email,
  //   required String password,
  // }) async {

  //   emit(
  //     state.copyWith(
  //       status: LoginStatus.loading,
  //     ),
  //   );

  //   await Future.delayed(
  //     const Duration(seconds: 2),
  //   );

  //   if (email == "admin@gmail.com" &&
  //       password == "123456") {

  //     emit(
  //       state.copyWith(
  //         status: LoginStatus.success,
  //       ),
  //     );

  //   } else {

  //     emit(
  //       state.copyWith(
  //         status: LoginStatus.error,
  //         message: "Invalid Credentials",
  //       ),
  //     );
  //   }
  // }
=======

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
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
}