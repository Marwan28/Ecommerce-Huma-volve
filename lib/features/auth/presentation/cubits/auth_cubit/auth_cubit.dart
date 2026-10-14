import 'package:ecommerce_app_huma_volve/features/auth/domain/usecases/login_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/usecases/signup_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase loginUsecase;
  final SignupUsecase signupUsecase;

  AuthCubit({required this.loginUsecase, required this.signupUsecase})
    : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    if (state is AuthLoading) return;
    emit(AuthLoading());
    final result = await loginUsecase.call(email: email, password: password);
    if (isClosed) return;
    result.fold(
      (failure) {
        emit(AuthFailure(message: failure.failureMessage));
      },
      (loginEntity) {
        emit(AuthLoginSuccess());
      },
    );
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    if (state is AuthLoading) return;
    emit(AuthLoading());
    final result = await signupUsecase.call(
      name: name,
      email: email,
      password: password,
    );
    if (isClosed) return;
    result.fold(
      (failure) {
        emit(AuthFailure(message: failure.failureMessage));
      },
      (signupEntity) {
        emit(AuthSignupSuccess());
      },
    );
  }
}
