import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/enums/role.dart';
import '../../../domain/repositories/i_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required IAuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(LoginInitial()) {
    on<LoginSubmitted>(_onSubmitted);
  }

  final IAuthenticationRepository _authenticationRepository;

  // String phoneFormatter(String value) {
  //   if (!value.startsWith('+') && value.startsWith('2')) return '+$value';
  //   if (!value.startsWith('+2')) return '+2$value';

  //   return value;
  // }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    // try {
    print('done');

    final result = event.role == Role.pharmacy
        ? await _authenticationRepository.logibProvider(
            event.loginParam,
          )
        : await _authenticationRepository.logIn(
            event.loginParam,
            // fcm: kFcm,
          );
    result.fold(
      (l) => emit(LoginFailure(l.errorMessege ?? '')),
      (r) => emit(LoginSuccess()),
    );
  }
}

class SingUpBloc extends Bloc<LoginEvent, LoginState> {
  SingUpBloc({
    required IAuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(LoginInitial()) {
    on<LoginRegisterSubmitted>(_onRegisterSubmitted);
  }

  final IAuthenticationRepository _authenticationRepository;

  Future<void> _onRegisterSubmitted(
    LoginRegisterSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    // try {

    final result = await _authenticationRepository.signIn(
      event.param,
    );
    result.fold(
      (l) => emit(LoginFailure(l.errorMessege ?? '')),
      (r) => emit(LoginSuccess()),
    );
  }
}

class SingUpBProviderloc extends Bloc<LoginEvent, LoginState> {
  SingUpBProviderloc({
    required IAuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(LoginInitial()) {
    on<LoginProviderSubmitted>(_onRegisterSubmitted);
  }

  final IAuthenticationRepository _authenticationRepository;

  Future<void> _onRegisterSubmitted(
    LoginProviderSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    // try {

    final result = await _authenticationRepository.signProvider(
      event.params,
    );
    result.fold(
      (l) => emit(LoginFailure(l.errorMessege ?? '')),
      (r) => emit(LoginSuccess()),
    );
  }
}
