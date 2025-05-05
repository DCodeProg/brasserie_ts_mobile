import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/sign_in_with_password.dart';
import '../../domain/usecases/sign_out.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetCurrentUser _getCurrentUser;
  final SignInWithPassword _signInWithPassword;
  final SignOut _signOut;

  AuthBloc({
    required GetCurrentUser getCurrentUser,
    required SignInWithPassword signInWithPassword,
    required SignOut signOut,
  }) : _getCurrentUser = getCurrentUser,
       _signInWithPassword = signInWithPassword,
       _signOut = signOut,
       super(AuthInitialState()) {
    on<AuthIsUserLoggedInEvent>(
      (event, emit) => _onAuthIsUserLoggedInEvent(event, emit),
    );
    on<AuthSignInWithPasswordEvent>(
      (event, emit) => _onAuthLoginWithPasswordEvent(event, emit),
    );
    on<AuthSignOutEvent>((event, emit) => _onAuthSignOutEvent(event, emit));

    add(AuthIsUserLoggedInEvent());
  }

  Future<void> _onAuthIsUserLoggedInEvent(
    AuthIsUserLoggedInEvent event,
    Emitter emit,
  ) async {
    emit(AuthLoadingState());

    final res = await _getCurrentUser();

    res.fold(
      (l) => emit(AuthLoggedOutState()),
      (r) => emit(AuthSuccessState(user: r)),
    );
  }

  Future<void> _onAuthLoginWithPasswordEvent(
    AuthSignInWithPasswordEvent event,
    Emitter emit,
  ) async {
    emit(AuthLoadingState());

    final res = await _signInWithPassword(
      SignInWithPasswordParams(email: event.email, password: event.password),
    );

    res.fold(
      (l) => emit(AuthFailureState(message: l.message)),
      (r) => emit(AuthSuccessState(user: r)),
    );
  }

  Future<void> _onAuthSignOutEvent(AuthSignOutEvent event, Emitter emit) async {
    emit(AuthLoadingState());

    final res = await _signOut(NoParams());

    res.fold(
      (l) => emit(AuthFailureState(message: l.message)),
      (r) => emit(AuthLoggedOutState()),
    );
  }
}
