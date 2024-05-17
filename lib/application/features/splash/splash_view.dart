import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_fb_bloc/application/features/auth/bloc/auth_bloc.dart';

class SplashViewWrapper extends StatelessWidget {
  const SplashViewWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()
        ..add(
          CheckLoginStatusEvent(),
        ),
      child: const SplashView(),
    );
  }
}

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    context.read<AuthBloc>().add(CheckLoginStatusEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
        if (state is UnAuthenticated) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/splash.png',
                height: 350,
                width: 350,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'Firebase Todo App',
              style: theme.textTheme.displayLarge,
            ),
            const CircularProgressIndicator(
              color: Colors.pink,
            )
          ],
        ),
      ),
    );
  }
}
