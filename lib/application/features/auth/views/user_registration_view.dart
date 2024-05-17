import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_fb_bloc/application/features/auth/bloc/auth_bloc.dart';
import 'package:todo_fb_bloc/application/features/auth/models/user_model.dart';
import 'package:todo_fb_bloc/application/features/auth/widgets/custom_textfield.dart';

class UserRegistrationViewWrapper extends StatelessWidget {
  const UserRegistrationViewWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const UserRegistrationView(),
    );
  }
}

class UserRegistrationView extends StatefulWidget {
  const UserRegistrationView({Key? key}) : super(key: key);

  @override
  State<UserRegistrationView> createState() => _UserRegistrationViewState();
}

class _UserRegistrationViewState extends State<UserRegistrationView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  late TextEditingController phoneController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (routes) => false,
            );
          });
        }
        if (state is AuthLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Register with email',
                          style: theme.textTheme.displayLarge,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormField(
                          controller: emailController,
                          hintText: 'email',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormField(
                          controller: passwordController,
                          hintText: 'password',
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormField(
                          controller: nameController,
                          hintText: 'Name',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormField(
                          controller: phoneController,
                          hintText: 'Phone',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  SignUpEvent(
                                    user: UserModel(
                                      name: nameController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      phone: phoneController.text.trim(),
                                    ),
                                  ),
                                );
                            print('onTap');
                          },
                          child: const Text('Register'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have account?',
                              style: theme.textTheme.bodySmall,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Login'),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
