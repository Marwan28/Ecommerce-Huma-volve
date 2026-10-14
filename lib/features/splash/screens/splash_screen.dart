import 'package:ecommerce_app_huma_volve/core/network/dio_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/repos/auth_repo_imp.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/usecases/login_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/usecases/signup_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/auth/presentation/cubits/session_cubit/session_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/main_navigation/screens/main_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/themes/theme.dart';
import '../../auth/presentation/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    final sessionCubit = context.read<SessionCubit>();
    await sessionCubit.checkSession();
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              (sessionCubit.state is SessionAuthenticated)
              ? MainNavigationScreen()
              : BlocProvider(
                  create: (context) {
                    final AuthRepoImp authRepoImp = AuthRepoImp(
                      authRemoteDataSource: AuthRemoteDataSource(
                        dioClient: DioClient(),
                      ),
                      authLocalDataSource: AuthLocalDataSource(
                        storage: FlutterSecureStorage(),
                      ),
                    );
                    return AuthCubit(
                      loginUsecase: LoginUsecase(authRepo: authRepoImp),
                      signupUsecase: SignupUsecase(authRepo: authRepoImp),
                    );
                  },
                  child: LoginScreen(),
                ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag, size: 120, color: AppTheme.primary),
            const SizedBox(height: 24),
            Text(
              'Huma-volve',
              style: Theme.of(context).textTheme.displayLarge
                  ?.copyWith(fontSize: 40, color: AppTheme.primary),
            ),
            const SizedBox(height: 8),
            Text(
              'Your Ultimate E-Commerce App',
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(fontSize: 16, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 48),
            CircularProgressIndicator(color: AppTheme.primary),
          ],
        ),
      ),
    );
  }
}
