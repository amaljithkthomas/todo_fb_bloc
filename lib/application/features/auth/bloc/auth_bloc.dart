import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:todo_fb_bloc/application/features/auth/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthBloc() : super(AuthInitial()) {
    on<CheckLoginStatusEvent>((event, emit) async {
      User? user;
      emit(AuthLoading());
      try {
        await Future.delayed(const Duration(seconds: 2), () {
          user = _auth.currentUser;
        });
        if (user != null) {
          emit(Authenticated(user: user));
        } else {
          emit(UnAuthenticated());
        }
      } catch (e) {
        emit(AuthenticationError(message: e.toString()));
      }
    });
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      print('signup started');
      try {
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: event.user.email!,
          password: event.user.password!,
        );
        final user = userCredential.user;
        print(user);
        if (user != null) {
          FirebaseFirestore.instance.collection("users").doc(user.uid).set({
            'uid': user.uid,
            'name': event.user.name,
            'phone': event.user.phone,
            'email': user.email,
            'password': event.user.password,
            'createdAt': DateTime.now(),
          });
          print(',,,,,,');
          emit(Authenticated(user: user));
        } else {
          emit(UnAuthenticated());
        }
      } catch (e) {
        emit(AuthenticationError(message: e.toString()));
      }
    });
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        final user = userCredential.user;
        if (user != null) {
          emit(Authenticated(user: user));
        } else {
          emit(UnAuthenticated());
        }
      } catch (e) {
        emit(
          AuthenticationError(
            message: e.toString(),
          ),
        );
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await _auth.signOut();
        await Future.delayed(const Duration(seconds: 1));
        emit(UnAuthenticated());
      } catch (e) {
        emit(AuthenticationError(message: e.toString()));
      }
    });
  }
}
