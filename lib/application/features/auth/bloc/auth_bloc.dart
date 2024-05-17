import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:todo_fb_bloc/application/features/auth/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<CheckLoginStatusEvent>((event, emit) async {
      FirebaseAuth _auth = FirebaseAuth.instance;
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
  }
}
