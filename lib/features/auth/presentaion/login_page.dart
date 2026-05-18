import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/routes/app_routes.dart';
import 'package:opsento_ats/features/auth/state/login_state.dart';

import '../cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState
    extends State<LoginPage> {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(

      create: (_) => LoginCubit(),

      child: Scaffold(

        backgroundColor: Colors.white,

        body: SafeArea(

          child: BlocConsumer<
              LoginCubit,
              LoginState>(

            listener: (context, state) {

              if (state.status ==
                  LoginStatus.success) {

                // ScaffoldMessenger.of(context)
                //     .showSnackBar(

                //   const SnackBar(
                //     content:
                //         Text(""),
                //   ),
                // );
                Navigator.pushReplacementNamed(context, AppRoutes.recruitermainlayout);
              }

              if (state.status ==
                  LoginStatus.error) {

                ScaffoldMessenger.of(context)
                    .showSnackBar(

                  SnackBar(
                    content:
                        Text(state.message),
                  ),
                );
              }
            },

            builder: (context, state) {

              final cubit =
                  context.read<LoginCubit>();

              return SingleChildScrollView(

                padding:
                    const EdgeInsets.all(24),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const SizedBox(height: 40),

                    const Text(

                      "Login",

                      style: TextStyle(
                        fontSize: 32,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(

                      "Please sign in to continue",

                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 50),

                    // EMAIL
                    const Text(
                      "Email",
                    ),

                    const SizedBox(height: 10),

                    TextField(

                      controller:
                          emailController,

                      decoration:
                          InputDecoration(

                        hintText:
                            "",

                        border:
                            OutlineInputBorder(

                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(

                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                      children: const [

                        Text("Password"),

                        Text(

                          "Forgot Password?",

                          style: TextStyle(
                            color:
                                Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    TextField(

                      controller:
                          passwordController,

                      obscureText:
                          state.obscurePassword,

                      decoration:
                          InputDecoration(

                        border:
                            OutlineInputBorder(

                          borderRadius:
                              BorderRadius.circular(14),
                        ),

                        suffixIcon:
                            IconButton(

                          onPressed: () {

                            cubit.togglePassword();
                          },

                          icon: Icon(

                            state.obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Row(

                    //   children: [

                    //     Checkbox(

                    //       value:
                    //           state.rememberMe,

                    //       onChanged: (value) {

                    //         cubit.toggleRememberMe(
                    //           value!,
                    //         );
                    //       },
                    //     ),

                    //     const Text(
                    //       "Remember me",
                    //     ),
                    //   ],
                    // ),

                    const SizedBox(height: 20),

                    // LOGIN BUTTON
                    SizedBox(

                      width: double.infinity,
                      height: 55,

                      child: ElevatedButton(

                        onPressed: () {

                          cubit.login(

                            email:
                                emailController.text,

                            password:
                                passwordController.text,
                          );
                        },

                        style:
                            ElevatedButton.styleFrom(

                          backgroundColor:
                              Colors.deepPurple,

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                        ),

                        child:
                            state.status ==
                                    LoginStatus.loading

                                ? const CircularProgressIndicator(
                                    color:
                                        Colors.white,
                                  )

                                : const Text(

                                    "Login",

                                    style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          Colors.white,
                                    ),
                                  ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    Row(

                      children: const [

                        // Expanded(
                        //   child: Divider(),
                        // ),

                        Padding(

                          padding:
                              EdgeInsets.symmetric(
                            horizontal: 12,
                          ),

                          // child: Text(
                          //   "or continue with",
                          // ),
                        ),

                        Expanded(
                          child: Divider(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Row(

                    //   mainAxisAlignment:
                    //       MainAxisAlignment.center,

                    //   children: [

                    //     socialButton(
                    //       "G",
                    //     ),

                    //     const SizedBox(width: 20),

                    //     socialButton(
                    //       "⊞",
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget socialButton(String text) {

    return Container(

      width: 65,
      height: 65,

      decoration: BoxDecoration(

        border: Border.all(
          color: Colors.grey.shade300,
        ),

        borderRadius:
            BorderRadius.circular(16),
      ),

      child: Center(

        child: Text(

          text,

          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}