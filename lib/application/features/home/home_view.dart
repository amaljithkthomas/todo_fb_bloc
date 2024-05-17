import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_fb_bloc/application/features/auth/bloc/auth_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is UnAuthenticated) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/login');
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
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LogoutEvent());
                },
                icon: const Icon(Icons.logout),
              )
            ],
          ),
          body: const Center(
            child: Text('Logged in'),
          ),
        );
      },
    );
  }
}
