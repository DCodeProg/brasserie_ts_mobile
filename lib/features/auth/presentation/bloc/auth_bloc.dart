import 'package:bloc/bloc.dart';
import '../../domain/usecases/sign_up.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/sign_in_with_password.dart';
import '../../domain/usecases/sign_out.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetCurrentUser getCurrentUser;
  final SignInWithPassword signInWithPassword;
  final SignOut signOut;
  final SignUp signUp;

  AuthBloc({
    required this.getCurrentUser,
    required this.signInWithPassword,
    required this.signOut,
    required this.signUp,
  }) : super(AuthInitialState()) {
    on<AuthIsUserLoggedInEvent>(
      (event, emit) => _onIsUserLoggedInEvent(event, emit),
    );
    on<AuthSignInWithPasswordEvent>(
      (event, emit) => _onLoginWithPasswordEvent(event, emit),
    );
    on<AuthSignOutEvent>((event, emit) => _onSignOutEvent(event, emit));
    on<AuthSignUpEvent>((event, emit) => _onSignUpEvent(event, emit));

    add(AuthIsUserLoggedInEvent());
  }

  Future<void> _onIsUserLoggedInEvent(
    AuthIsUserLoggedInEvent event,
    Emitter emit,
  ) async {
    emit(AuthLoadingState());

    final res = await getCurrentUser();

    res.fold(
      (l) => emit(AuthLoggedOutState()),
      (r) => emit(AuthSuccessState(user: r)),
    );
  }

  Future<void> _onLoginWithPasswordEvent(
    AuthSignInWithPasswordEvent event,
    Emitter emit,
  ) async {
    emit(AuthLoadingState());

    final res = await signInWithPassword(
      SignInWithPasswordParams(email: event.email, password: event.password),
    );

    res.fold(
      (l) => emit(AuthFailureState(message: l.message)),
      (r) => emit(AuthSuccessState(user: r)),
    );
  }

  Future<void> _onSignOutEvent(AuthSignOutEvent event, Emitter emit) async {
    emit(AuthLoadingState());

    final res = await signOut(NoParams());

    res.fold(
      (l) => emit(AuthFailureState(message: l.message)),
      (r) => emit(AuthLoggedOutState()),
    );
  }

  Future<void> _onSignUpEvent(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());

    final res = await signUp(
      SignUpParams(
        email: event.email,
        password: event.password,
        nom: event.nom,
        prenom: event.prenom,
      ),
    );

    res.fold(
      (l) => emit(AuthFailureState(message: l.message)),
      (r) => emit(AuthSuccessState(user: r)),
    );
  }
}
