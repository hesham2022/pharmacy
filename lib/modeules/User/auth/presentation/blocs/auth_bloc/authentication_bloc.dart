import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/useCase/use_case.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/i_repository.dart';
import '../../../domain/usecases/get_me.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required IAuthenticationRepository authenticationRepository,
    required GetMe getMe,
  })  : _authenticationRepository = authenticationRepository,
        _getMe = getMe,
        super(AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);

    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final IAuthenticationRepository _authenticationRepository;

  final GetMe _getMe;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(AuthenticationState.unauthenticated(''));
      case AuthenticationStatus.signUpSucess:
        final user = await _getMe(NoParams());
        return user.fold(
          (l) => emit(AuthenticationState.unauthenticated(l.errorMessege)),
          (r) {
            emit(AuthenticationState.authenticated(r));
          },
        );

      case AuthenticationStatus.authenticated:
        final user = await _getMe(NoParams());
        return user.fold(
          (l) => emit(AuthenticationState.unauthenticated(l.errorMessege)),
          (r) {
            emit(AuthenticationState.authenticated(r));
          },
        );

      case AuthenticationStatus.unknown:
        return emit(AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }
}
