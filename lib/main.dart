import 'package:ecommerce_app_huma_volve/core/network/dio_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/repos/auth_repo_imp.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/usecases/check_session_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/usecases/logout_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/auth/presentation/cubits/session_cubit/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'core/themes/theme.dart';
import 'features/splash/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SessionCubit>(
      create: (context) {
        final AuthRepoImp authRepoImp = AuthRepoImp(
          authRemoteDataSource: AuthRemoteDataSource(
            dioClient: DioClient(),
          ),
          authLocalDataSource: AuthLocalDataSource(
            storage: FlutterSecureStorage(),
          ),
        );
        return SessionCubit(
        checkSessionUsecase: CheckSessionUsecase(authRepo: authRepoImp),
        logoutUsecase: LogoutUsecase(authRepo: authRepoImp),
      );
      },
      child: MaterialApp(
        title: 'E-Commerce App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
