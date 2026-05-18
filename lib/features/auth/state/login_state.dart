
enum LoginStatus {
  initial,
  loading,
  success,
  error,
}

class LoginState {

  final bool obscurePassword;
  final bool rememberMe;
  final LoginStatus status;
  final String message;

  const LoginState({

    this.obscurePassword = true,
    this.rememberMe = false,
    this.status = LoginStatus.initial,
    this.message = '',
  });

  LoginState copyWith({

    bool? obscurePassword,
    bool? rememberMe,
    LoginStatus? status,
    String? message,
  }) {

    return LoginState(

      obscurePassword:
          obscurePassword ??
              this.obscurePassword,

      rememberMe:
          rememberMe ??
              this.rememberMe,

      status:
          status ?? this.status,

      message:
          message ?? this.message,
    );
  }

  @override
  List<Object> get props => [

        obscurePassword,
        rememberMe,
        status,
        message,
      ];
}