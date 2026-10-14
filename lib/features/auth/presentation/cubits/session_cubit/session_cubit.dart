
import 'package:ecommerce_app_huma_volve/features/auth/domain/usecases/check_session_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final CheckSessionUsecase checkSessionUsecase;
  final LogoutUsecase logoutUsecase;

  SessionCubit({
    required this.checkSessionUsecase,
    required this.logoutUsecase,
  }) : super(SessionInitial());

  Future<void> checkSession() async {
    final result = await checkSessionUsecase.call();
    if (isClosed) return;
    result.fold(
          (_) => emit(SessionUnauthenticated()),
          (hasSession) => emit(
        hasSession ? SessionAuthenticated() : SessionUnauthenticated(),
      ),
    );
  }

  Future<void> logout() async {
    final result = await logoutUsecase.call();
    if (isClosed) return;
    result.fold(
          (failure) => emit(SessionFailure(message: failure.failureMessage)),
          (_) => emit(SessionUnauthenticated()),
    );
  }
}
