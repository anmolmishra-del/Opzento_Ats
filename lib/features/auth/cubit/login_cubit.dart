import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import 'package:opsento_ats/core/services/api_service.dart';
import 'package:opsento_ats/features/auth/state/login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  LoginCubit()
      : super(
          const LoginState(),
        );

  final service =
      OdooService();

  final storage =
      const FlutterSecureStorage();

  /// PASSWORD TOGGLE
  void togglePassword() {

    emit(
      state.copyWith(
        obscurePassword:
            !state.obscurePassword,
      ),
    );
  }

  /// REMEMBER ME
  void toggleRememberMe(
    bool value,
  ) {

    emit(
      state.copyWith(
        rememberMe: value,
      ),
    );
  }

  /// LOGIN
  Future<void> login({

    required String email,

    required String password,

  }) async {

    emit(
      state.copyWith(
        status:
            LoginStatus.loading,
      ),
    );

    try {

      debugPrint(
        "LOGIN STARTED",
      );

      /// ODOO LOGIN
      final response =
          await service.login(

        email: email,

        password: password,
      );

      debugPrint(
        "LOGIN SUCCESS",
      );

      debugPrint(
        "SESSION ID => ${response.id}",
      );

      debugPrint(
        "USER ID => ${response.userId}",
      );

      /// SAVE FULL SESSION
      await storage.write(

        key: "session",

        value:
    jsonEncode(
      response.toJson(),
    ),
      );

      /// SAVE TOKEN
      await storage.write(

        key: "token",

        value: response.id,
      );

      /// SAVE USER ID
      await storage.write(

        key: "userId",

        value:
            response.userId
                .toString(),
      );

      /// SAVE DATABASE
      await storage.write(

        key: "db",

        value:
            service.database,
      );

      /// SAVE BASE URL
      await storage.write(

        key: "baseUrl",

        value:
            service.baseUrl,
      );

      /// SAVE LOGIN STATUS
      await storage.write(

        key: "is_logged_in",

        value: "true",
      );

      /// REMEMBER ME
      await storage.write(

        key: "rememberMe",

        value:
            state.rememberMe
                .toString(),
      );

      /// SAVE EMAIL
      await storage.write(

        key: "email",

        value: email,
      );

      /// SAVE PASSWORD
      await storage.write(

        key: "password",

        value: password,
      );

      /// FIRST TIME
      await storage.write(

        key: "first_time",

        value: "done",
      );

      debugPrint(
        "SESSION SAVED SUCCESSFULLY",
      );

      emit(
        state.copyWith(
          status:
              LoginStatus.success,
        ),
      );

    } on OdooSessionExpiredException {

      debugPrint(
        "SESSION EXPIRED",
      );

      emit(
        state.copyWith(

          status:
              LoginStatus.error,

          message:
              "Session Expired Please Login Again",
        ),
      );

    } on OdooException catch (e) {

      debugPrint(
        "ODOO ERROR => $e",
      );

      emit(
        state.copyWith(

          status:
              LoginStatus.error,

          message:
              "Wrong Email or Password",
        ),
      );

    } catch (e) {

      debugPrint(
        "LOGIN ERROR => $e",
      );

      emit(
        state.copyWith(

          status:
              LoginStatus.error,

          message:
              "Something went wrong",
        ),
      );
    }
  }

  /// CHECK LOGIN STATUS
  Future<void> checkLoginStatus() async {

    try {

      final rememberMe =
          await storage.read(
        key: "rememberMe",
      );

      /// REMEMBER ME FALSE
      if (rememberMe != "true") {

        emit(
          state.copyWith(
            status:
                LoginStatus.initial,
          ),
        );

        return;
      }

      final sessionData =
          await storage.read(
        key: "session",
      );

      final baseUrl =
          await storage.read(
        key: "baseUrl",
      );

      /// NO SESSION
      if (sessionData == null ||
          baseUrl == null) {

        emit(
          state.copyWith(
            status:
                LoginStatus.initial,
          ),
        );

        return;
      }

      debugPrint(
        "RESTORING SESSION",
      );

      debugPrint(
        sessionData,
      );

      /// SESSION RESTORE
      final session =
          OdooSession.fromJson(
        service.convertStringToMap(
          sessionData,
        ),
      );

      final client =
          OdooClient(

        baseUrl,

        sessionId: session,
      );

      /// CHECK SESSION
      await client.checkSession();

      debugPrint(
        "SESSION VALID",
      );

      emit(
        state.copyWith(
          status:
              LoginStatus.success,
        ),
      );

    } catch (e) {

      debugPrint(
        "SESSION CHECK ERROR => $e",
      );

      await logout();
    }
  }

  /// LOGOUT
  Future<void> logout() async {

    await storage.deleteAll();

    emit(
      state.copyWith(
        status:
            LoginStatus.initial,
      ),
    );
  }
  
}