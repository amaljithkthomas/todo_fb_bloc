import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_fb_bloc/application/features/auth/bloc/auth_bloc.dart';
import 'package:todo_fb_bloc/application/features/auth/views/login_view.dart';
import 'package:todo_fb_bloc/application/features/auth/views/user_registration_view.dart';
import 'package:todo_fb_bloc/application/features/home/home_view.dart';
import 'package:todo_fb_bloc/application/features/splash/splash_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xfff263147),
          appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xfff263147),
              iconTheme: IconThemeData(
                color: Colors.white,
              )),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
            bodySmall: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
          //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashView(),
          '/login': (context) => const LoginView(),
          '/home': (context) => const HomeView(),
          '/register': (context) => const UserRegistrationView(),
        },
      ),
    );
  }
}
