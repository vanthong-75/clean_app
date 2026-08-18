
import 'package:clean_app/bloc/auth/auth_bloc.dart';
import 'package:clean_app/feature/presentation/components/button_component.dart';
import 'package:clean_app/feature/presentation/components/input_text.dart';
import 'package:clean_app/feature/presentation/layouts/home.dart';
import 'package:clean_app/feature/presentation/pages/Sign_up.dart';
import 'package:clean_app/feature/presentation/pages/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isRememberMe = false;

  final TextEditingController Username = TextEditingController();
  final TextEditingController Password = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('ແຈ້ງເຕືອນ'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ຕົກລົງ'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    Username.dispose();
    Password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Provide the AuthBloc scoped to this page.
    // If AuthBloc is already provided higher up the tree (e.g. in main.dart),
    // remove this BlocProvider and use BlocConsumer<AuthBloc, AuthState> directly.
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            _showErrorDialog(state.message);
          } else if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Scaffold(
            body: Stack(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  color: const Color.fromARGB(255, 223, 129, 129),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 80, left: 25, right: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello',
                          style: TextStyle(fontSize: 32, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Securely log in with your',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'email and password.',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height * 0.7,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(40)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Sign in',
                                  style: TextStyle(fontSize: 25)),
                              const SizedBox(height: 20),
                              InputText.inputText(
                                'Enter your email',
                                const Icon(Icons.email),
                                Username,
                              ),
                              const SizedBox(height: 15),
                              InputText.inputText(
                                'Enter password',
                                const Icon(Icons.lock),
                                Password,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isRememberMe = !isRememberMe;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: Checkbox(
                                            value: isRememberMe,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isRememberMe = value ?? false;
                                              });
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Text('Remember me'),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgotPassword(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Forgot password',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              isLoading
                                  ? const Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12),
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : ButtonComponent.buttonComponent(
                                      context,
                                      'Sign in',
                                      const Icon(Icons.login,
                                          color: Colors.white, size: 30),
                                      () {
                                        context.read<AuthBloc>().add(
                                              LoginRequested(
                                                email: Username.text,
                                                password: Password.text,
                                              ),
                                            );
                                      },
                                    ),
                              const SizedBox(height: 40),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Do not have an account?'),
                                  const SizedBox(width: 9),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUp(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Sign up',
                                      style: TextStyle(
                                        color: Color.fromRGBO(3, 131, 235, 1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}